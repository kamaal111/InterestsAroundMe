//
//  IAMNetworker.swift
//  
//
//  Created by Kamaal M Farah on 28/12/2021.
//

import Foundation
import XiphiasNet

/// Main networking layer of the app
public struct IAMNetworker {
    private var foursquareClient: FoursquareClient?

    private var kowalskiAnalysis: Bool

    /// IAMNetworker initializer.
    /// If the Foursquare client is necessary, then the `foursquareAPIKey` param must not be `nil`.
    /// - Parameters:
    ///   - foursquareAPIKey: Foursquares client API key
    ///   - kowalskiAnalysis: when in need of more logging set this to true
    public init(foursquareAPIKey: String? = nil, kowalskiAnalysis: Bool = false) {
        if let foursquareAPIKey = foursquareAPIKey {
            self.foursquareClient = FoursquareClient(apiKey: foursquareAPIKey)
        }
        self.kowalskiAnalysis = kowalskiAnalysis
    }

    public enum IAMNetworkerErrors: Error, LocalizedError {
        case generalError(error: Error)
        case responseError(message: String, code: Int)
        case notAValidJSON
        case parsingError(error: Error)
        case invalidURL(url: String)
        case foursquareNotAuthorized

        public var errorDescription: String {
            switch self {
            case let  .generalError(error): return "Unknown error of \(error)"
            case let .responseError(message, code): return "\(message); status: \(code)"
            case .notAValidJSON: return "Invalid JSON response"
            case let .parsingError(error): return "JSON parsing error; error: \(error)"
            case let .invalidURL(url): return "Invalid url provided of \(url)"
            case .foursquareNotAuthorized: return "Networker not initialized with API token"
            }
        }
    }

    /// Sorting methods on the Foursquare client
    public enum PlacesSort {
        /// Sort by popularity
        case popular
        /// Sort from newest
        case newest

        var toFoursquarePlaceSort: FoursquareClient.PlacesSort {
            switch self {
            case .popular: return .popular
            case .newest: return .newest
            }
        }
    }

    /// To get the tips of the given place
    /// - Parameters:
    ///   - place: the place to get the tips from
    ///   - sort: sorting method
    ///   - limit: maximum amount of items. By default this is 10, maximum is 50 and minimum 1.
    ///   - preview: if to return preview data
    /// - Returns: on success returns a Array of ``IAMNPlaceTip``.
    public func getPlaceTips(
        of place: IAMNPlace,
        sort: PlacesSort?,
        limitTo limit: Int?,
        preview: Bool = false) async -> Result<[IAMNPlaceTip], IAMNetworkerErrors> {
            guard !preview else { return .success(.preview) }
            guard let foursquareClient = self.foursquareClient else { return .failure(.foursquareNotAuthorized) }
            let result = await foursquareClient.getPlaceTips(
                of: place.id,
                sort: sort?.toFoursquarePlaceSort,
                limitTo: limit)
            return result.mapError(handleError(_:))
        }

    /// To get the plhotos of the given place
    /// - Parameters:
    ///   - place: the place to get the photos from
    ///   - sort: sorting method
    ///   - limit: maximum amount of items. By default this is 10, maximum is 50 and minimum 1.
    ///   - preview: if to return preview data
    /// - Returns: on success returns a Array of ``IAMNPlacePhoto``.
    public func getPlacePhotos(
        of place: IAMNPlace,
        sort: PlacesSort?,
        limitTo limit: Int?,
        preview: Bool = false) async -> Result<[IAMNPlacePhoto], IAMNetworkerErrors> {
            guard !preview else { return .success(.preview) }
            guard let foursquareClient = self.foursquareClient else { return .failure(.foursquareNotAuthorized) }
            let result = await foursquareClient.getPlacePhotos(
                of: place.id,
                sort: sort?.toFoursquarePlaceSort,
                limitTo: limit)
            return result.mapError(handleError(_:))
        }

    /// To find nearby places depending on the given coordinates given
    /// - Parameters:
    ///   - coordinate: a tupple of `(latitude, longitude)`
    ///   - limit: maximum amount of items. By default this is 10, maximum is 50 and minimum 1.
    ///   - preview: if to return preview data
    /// - Returns: on success returns ``IAMNPlacesResult``.
    public func findNearbyPlaces(
        of coordinate: (lat: Double, lon: Double),
        limitTo limit: Int?,
        preview: Bool = false) async -> Result<IAMNPlacesResult, IAMNetworkerErrors> {
            guard !preview else { return .success(.preview) }
            guard let foursquareClient = self.foursquareClient else { return .failure(.foursquareNotAuthorized) }
            let result = await foursquareClient.findNearbyPlaces(of: coordinate, limitTo: limit)
            return result.mapError(handleError(_:))
        }

    private func handleError(_ error: XiphiasNet.Errors) -> IAMNetworkerErrors {
        switch error {
        case let  .generalError(error): return .generalError(error: error)
        case let .responseError(message, code): return .responseError(message: message, code: code)
        case .notAValidJSON: return .notAValidJSON
        case let .parsingError(error): return .parsingError(error: error)
        case let .invalidURL(url): return .invalidURL(url: url)
        }
    }
}
