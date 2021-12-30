//
//  DetailsScreen+ViewModel.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation
import IAMNetworker
import os.log

extension DetailsScreen {
    @MainActor
    final class ViewModel: ObservableObject {

        @Published private(set) var place: IAMNPlace? {
            didSet { placeDidSet() }
        }
        @Published private(set) var error: Errors?
        @Published private var photos: [IAMNPlacePhoto] = []

        private var preview: Bool = false
        private let networker = IAMNetworker(foursquareAPIKey: Config.foursquareApiKey, kowalskiAnalysis: false)

        init() { }

        func setPreview(_ preview: Bool) {
            self.preview = preview
        }

        func setPlace(_ place: IAMNPlace) {
            self.place = place
        }

        private func placeDidSet() {
            guard let place = self.place else { return }

            Task {
                let result = await networker.getPlacePhotos(
                    of: place,
                    sort: .popular,
                    limitTo: Features.placePhotosLimit)
                let photos: [IAMNPlacePhoto]
                switch result {
                case .failure(let failure):
                    error = .photoFetch
                    Logger.detailScreen.error("error while fetching places photos; \(failure.errorDescription);")
                    return
                case .success(let success): photos = success
                }

                self.photos = photos
            }
        }

    }
}

extension DetailsScreen.ViewModel {
    enum Errors: Error, LocalizedError {
        case photoFetch

        var errorDescription: String {
            switch self {
            case .photoFetch: return "Something went wrong while getting this places photos"
            }
        }
    }
}
