//
//  IAMNetworker.swift
//  
//
//  Created by Kamaal M Farah on 28/12/2021.
//

import Foundation
import XiphiasNet

public struct IAMNetworker {
    private var foursquareClient: FoursquareClient?

    private var kowalskiAnalysis: Bool

    public init(foursquareAPIKey: String? = nil, kowalskiAnalysis: Bool = false) {
        if let foursquareAPIKey = foursquareAPIKey {
            self.foursquareClient = FoursquareClient(apiKey: foursquareAPIKey)
        }
        self.kowalskiAnalysis = kowalskiAnalysis
    }

    public enum IAMNetworkerErrors: Error {
        case generalError(error: Error)
        case responseError(message: String, code: Int)
        case notAValidJSON
        case parsingError(error: Error)
        case invalidURL(url: String)
        case foursquareNotAuthorized
    }

    public func findNearbyPlaces(
        of coordinate: (lat: Double, lon: Double),
        limitTo limit: Int,
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
