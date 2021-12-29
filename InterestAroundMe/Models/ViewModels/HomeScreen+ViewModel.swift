//
//  HomeScreen+ViewModel.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation
import IAMNetworker

extension HomeScreen {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var places: [IAMNPlace] = []

        private let networker = IAMNetworker(foursquareAPIKey: Config.foursquareApiKey, kowalskiAnalysis: false)

        init() { }

        func loadViewData(preview: Bool = false) async throws {
            let result = try await networker.findNearbyPlaces(
                of: (41.8781, -87.6298),
                limitTo: 5,
                preview: preview)
                .get()
            places = result.results
        }
    }
}
