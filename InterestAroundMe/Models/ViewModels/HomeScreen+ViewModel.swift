//
//  HomeScreen+ViewModel.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import IAMNetworker
import os.log

extension HomeScreen {
    @MainActor
    final class ViewModel: ObservableObject {

        @Published private(set) var places: [IAMNPlace] = []
        @Published private(set) var categoryIcons: [String: Data] = [:]
        @Published var loadingData = false

        private var initialViewDataLoaded = false

        private let networker = IAMNetworker(foursquareAPIKey: Config.foursquareApiKey, kowalskiAnalysis: false)

        init() { }

        func getExtraSmallCategoryIconImageData(_ category: IAMNPlaceCategory?) -> Data? {
            guard let category = category else { return nil }
            let key = "\(category.name)_32"
            return categoryIcons[key]
        }

        func loadViewData(
            userCoordinates: (lat: Double, lon: Double),
            preview: Bool = false) async -> Result<Void, IAMNetworker.IAMNetworkerErrors> {
                guard !initialViewDataLoaded else { return .success(Void()) }

                loadingData = true
                let result = await networker.findNearbyPlaces(
                    of: userCoordinates,
                    limitTo: Features.initialPlacesLimit,
                    preview: preview)
                let places: [IAMNPlace]
                switch result {
                case .failure(let failure):
                    loadingData = false
                    return .failure(failure)
                case .success(let success): places = success.results
                }

                initialViewDataLoaded = true
                self.places = places

                loadCategoryIcons(fromPlaces: places)

                loadingData = false
                return .success(Void())
            }

        private func loadCategoryIcons(fromPlaces places: [IAMNPlace]) {
            Task(priority: .background) {
                let categoryIconsKeys = categoryIcons.keys
                let categories: [String: Data] = places
                    .reduce([:], {
                        var mutResults = $0
                        for category in $1.categories {
                            let key = "\(category.name)_32"
                            if !categoryIconsKeys.contains(key) && mutResults[key] == nil,
                                let url = category.icon.iconURL(ofSize: .extraSmall) {
                                do {
                                    mutResults[key] = try Data(contentsOf: url)
                                } catch {
                                    Logger.homeScreen.warning("could not fetch from \(url)")
                                }
                            }
                        }
                        return mutResults
                    })
                var categoryIcons = self.categoryIcons
                for category in categories {
                    categoryIcons[category.key] = category.value
                }
                self.categoryIcons = categoryIcons
            }
        }

    }
}
