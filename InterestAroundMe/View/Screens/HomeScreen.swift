//
//  HomeScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import PopperUp
import os.log
import CoreLocation

struct HomeScreen: View {
    @EnvironmentObject
    private var popperUpManager: PopperUpManager
    @EnvironmentObject
    private var locationManager: LocationManager

    @StateObject private var viewModel = ViewModel()

    private let preview: Bool

    init(preview: Bool = false) {
        self.preview = preview
    }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.places) { place in
                    InterestPlace(
                        place: place,
                        imageData: viewModel.getExtraSmallCategoryIconImageData(place.categories.first),
                        action: { print(place) })
                }
            }
        }
        .navigationTitle(Text("Interests"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: handleOnAppear)
        .onChange(of: locationManager.error, perform: handleLocationErrorChange(_:))
        .onChange(of: locationManager.userLocation, perform: loadInitialViewData(_:))
    }

    private func handleLocationErrorChange(_ newValue: LocationManager.Errors?) {
        guard let error = newValue else { return }
        popperUpManager.showPopup(
            ofType: .error,
            title: "Sorry",
            description: error.localizedDescription,
            timeout: 3)
    }

    private func handleOnAppear() {
        locationManager.requestPermission()

        loadInitialViewData(locationManager.userLocation)
    }

    private func loadInitialViewData(_ userLocation: CLLocation?) {
        guard let userLocation = userLocation else { return }

        let userCoordinates = userLocation.coordinate
        Task {
            let result = await viewModel.loadViewData(
                userCoordinates: (userCoordinates.latitude, userCoordinates.longitude),
                preview: preview)
            switch result {
            case .failure(let failure):
                Logger.homeScreen.error("error while loading view data; \(failure.errorDescription);")
                popperUpManager.showPopup(
                    ofType: .error,
                    title: "Sorry",
                    description: "Something went wrong while fetching nearby venues")
            case .success: break
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(preview: true)
            .environmentObject(LocationManager())
            .withPopperUp(PopperUpManager())
    }
}
