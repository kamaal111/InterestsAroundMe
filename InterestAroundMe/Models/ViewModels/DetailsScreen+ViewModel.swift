//
//  DetailsScreen+ViewModel.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation
import IAMNetworker
import os.log
import ShrimpExtensions

extension DetailsScreen {
    @MainActor
    final class ViewModel: ObservableObject {

        @Published private(set) var place: IAMNPlace? {
            didSet { placeDidSet() }
        }
        @Published private(set) var error: Errors?
        @Published private(set) var photos: [Data] = []
        @Published private(set) var tips: [IAMNPlaceTip] = []

        private var preview = false
        private let networker = IAMNetworker(foursquareAPIKey: Config.foursquareApiKey, kowalskiAnalysis: false)

        init() { }

        var showLocationSection: Bool {
            guard let location = place?.location else { return false }
            return (location.address != nil
                    || location.locality != nil
                    || (!(location.neighborhood ?? []).isEmpty)
                    || location.region != nil)
        }

        func setPreview(_ preview: Bool) {
            self.preview = preview
        }

        func setPlace(_ place: IAMNPlace) {
            self.place = place
        }

        private func placeDidSet() {
            guard let place = self.place else { return }

            getPhotos(of: place)
            getTips(of: place)
        }

        private func getTips(of place: IAMNPlace) {
            Task {
                let result = await networker.getPlaceTips(
                    of: place,
                    sort: .popular,
                    limitTo: Features.placePhotosLimit,
                    preview: preview)
                let tips: [IAMNPlaceTip]
                switch result {
                case .failure(let failure):
                    error = .photoFetch
                    Logger.detailScreen.error("error while fetching places tips; \(failure.errorDescription);")
                    return
                case .success(let success): tips = success
                }

                self.tips = tips
            }
        }

        private func getPhotos(of place: IAMNPlace) {
            Task {
                let result = await networker.getPlacePhotos(
                    of: place,
                    sort: .popular,
                    limitTo: Features.placePhotosLimit,
                    preview: preview)
                let photos: [IAMNPlacePhoto]
                switch result {
                case .failure(let failure):
                    error = .photoFetch
                    Logger.detailScreen.error("error while fetching places photos; \(failure.errorDescription);")
                    return
                case .success(let success): photos = success
                }

                self.photos = photos
                    .compactMap({
                        guard let url = $0.photoURL(ofSize: .squared(200)) else { return nil }
                        do {
                            return try Data(contentsOf: url)
                        } catch {
                            Logger.detailScreen.error(
                                "something went wrong while fetching data from photo; \(error.localizedDescription)")
                            return nil
                        }
                    })
            }
        }

    }
}

extension DetailsScreen.ViewModel {
    enum Errors: Error, LocalizedError {
        case photoFetch
        case tipsFetch

        var errorDescription: String {
            switch self {
            case .photoFetch: return "Something went wrong while getting this places photos"
            case .tipsFetch: return "Something went wrong while getting this places tips"
            }
        }
    }
}
