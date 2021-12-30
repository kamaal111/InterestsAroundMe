//
//  HomeScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import PopperUp
import os.log

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
    }

    private func handleOnAppear() {
        Task {
            do {
                try await viewModel.loadViewData(preview: preview)
            } catch {
                Logger.homeScreen.error("Hello \(error.localizedDescription)")
                popperUpManager.showPopup(
                    ofType: .error,
                    title: "Sorry",
                    description: "Something went wrong while fetching nearby venues")
            }
        }
        locationManager.requestPermission()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(preview: true)
            .environmentObject(LocationManager())
            .withPopperUp(PopperUpManager())
    }
}
