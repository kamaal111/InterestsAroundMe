//
//  FoursquareClient.swift
//  
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation
import XiphiasNet
import ShrimpExtensions

struct FoursquareClient {
    var apiKey: String

    private var defaultHeaders: [String: String] {
        [
            "Authorization": apiKey,
            "Accept": "application/json"
        ]
    }

    func findNearbyPlaces(
        of coordinate: (lat: Double, lon: Double),
        limitTo limit: Int) async -> Result<IAMNPlacesResult, XiphiasNet.Errors> {
            let queryItems = [
                URLQueryItem(name: "ll", value: "\(coordinate.lat.toFixed(4)),\(coordinate.lon.toFixed(4))"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
            let result: Result<Response<IAMNPlacesResult>, XiphiasNet.Errors> = await XiphiasNet.request(
                from: .foursquareNearbyPlaces(queryItems: queryItems),
                headers: defaultHeaders)
            return result.map(\.data)
        }
}

extension Endpoint {
    private static let foursquareHost = "api.foursquare.com"

    static func foursquareNearbyPlaces(queryItems: [URLQueryItem] = []) -> Endpoint {
        Endpoint(host: foursquareHost, path: "v3/places/nearby", queryItems: queryItems)
    }
}
