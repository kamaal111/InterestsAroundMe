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
import SalmonUI

struct HomeScreen: View {
    @EnvironmentObject
    private var popperUpManager: PopperUpManager
    @EnvironmentObject
    private var locationManager: LocationManager

    @StateObject private var viewModel = ViewModel()
    @StateObject private var stackNavigator = StackNavigator()

    private let preview: Bool

    init(preview: Bool = false) {
        self.preview = preview
    }

    var body: some View {
        VStack {
            List {
                if !locationManager.locationIsAccessible {
                    Text("We need your current location to get the nearby venues")
                        .font(.title3)
                        .bold()
                } else if viewModel.loadingData {
                    KActivityIndicator(isAnimating: $viewModel.loadingData, style: .large)
                        .ktakeSizeEagerly(alignment: .center)
                } else if viewModel.places.isEmpty {
                    Text("No nearby venues")
                        .font(.title3)
                        .bold()
                } else {
                    ForEach(viewModel.places) { place in
                        InterestPlace(
                            place: place,
                            imageData: viewModel.getExtraSmallCategoryIconImageData(place.categories.first),
                            action: { stackNavigator.navigate(to: .details, options: ["place": place]) })
                    }
                }
            }
        }
        .navigationTitle(Text("Interests"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: handleOnAppear)
        .onChange(of: locationManager.error, perform: handleLocationErrorChange(_:))
        .onChange(of: locationManager.userLocation, perform: loadInitialViewData(_:))
        .withNavigationPoints(selectedScreen: $stackNavigator.selectedScreen, stackNavigator: stackNavigator)
    }

    private func handleLocationErrorChange(_ newValue: LocationManager.Errors?) {
        guard let error = newValue else {
            popperUpManager.hidePopup()
            return
        }
        popperUpManager.showPopup(
            ofType: .error,
            title: "Sorry",
            description: error.errorDescription,
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
