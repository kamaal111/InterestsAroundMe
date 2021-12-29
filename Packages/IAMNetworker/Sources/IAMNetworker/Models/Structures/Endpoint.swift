//
//  Endpoint.swift
//  
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation

struct Endpoint {
    var host: String
    var path: String
    var queryItems: [URLQueryItem] = []

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            fatalError("Invalid URL components: \(components)")
        }

        return url
    }
}
