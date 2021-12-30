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

    enum PlacesSort: String {
        case popular = "POPULAR"
        case newest = "NEWEST"
    }

    private var defaultHeaders: [String: String] {
        [
            "Authorization": apiKey,
            "Accept": "application/json"
        ]
    }

    func getPlaceTips(
        of placeID: String,
        sort: PlacesSort?,
        limitTo limit: Int?) async -> Result<[IAMNPlaceTip], XiphiasNet.Errors> {
            let result: Result<Response<[IAMNPlaceTip]>, XiphiasNet.Errors> = await XiphiasNet.request(
                from: .foursquarePlaceTips(placeID: placeID, sort: sort, limit: limit),
                headers: defaultHeaders)
            return result.map(\.data)
    }

    func getPlacePhotos(
        of placeID: String,
        sort: PlacesSort?,
        limitTo limit: Int?) async -> Result<[IAMNPlacePhoto], XiphiasNet.Errors> {
            let result: Result<Response<[IAMNPlacePhoto]>, XiphiasNet.Errors> = await XiphiasNet.request(
                from: .foursquarePlacePhotos(placeID: placeID, sort: sort, limit: limit),
                headers: defaultHeaders)
            return result.map(\.data)
    }

    func findNearbyPlaces(
        of coordinate: (lat: Double, lon: Double),
        limitTo limit: Int?) async -> Result<IAMNPlacesResult, XiphiasNet.Errors> {
            let result: Result<Response<IAMNPlacesResult>, XiphiasNet.Errors> = await XiphiasNet.request(
                from: .foursquareNearbyPlaces(coordinate: coordinate, limit: limit),
                headers: defaultHeaders)
            return result.map(\.data)
        }
}

extension Endpoint {
    private static let foursquareHost = "api.foursquare.com"

    static func foursquarePlaceTips(placeID: String, sort: FoursquareClient.PlacesSort?, limit: Int?) -> Endpoint {
        var queryItems: [URLQueryItem] = []
        if let sort = sort {
            queryItems.append(.init(name: "sort", value: sort.rawValue))
        }
        if let limit = limit {
            queryItems.append(.init(name: "limit", value: "\(limit)"))
        }
        return Endpoint(host: foursquareHost, path: "v3/places/\(placeID)/tips", queryItems: queryItems)
    }

    static func foursquarePlacePhotos(placeID: String, sort: FoursquareClient.PlacesSort?, limit: Int?) -> Endpoint {
        var queryItems: [URLQueryItem] = []
        if let sort = sort {
            queryItems.append(.init(name: "sort", value: sort.rawValue))
        }
        if let limit = limit {
            queryItems.append(.init(name: "limit", value: "\(limit)"))
        }
        return Endpoint(host: foursquareHost, path: "v3/places/\(placeID)/photos", queryItems: queryItems)
    }

    static func foursquareNearbyPlaces(coordinate: (lat: Double, lon: Double), limit: Int?) -> Endpoint {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: "\(coordinate.lat.toFixed(4)),\(coordinate.lon.toFixed(4))")
        ]
        if let limit = limit {
            queryItems.append(.init(name: "limit", value: "\(limit)"))
        }
        return Endpoint(host: foursquareHost, path: "v3/places/nearby", queryItems: queryItems)
    }
}
