//
//  IAMNPlacePhoto.swift
//  
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation
import CoreGraphics

public struct IAMNPlacePhoto: Codable, Hashable, Identifiable {
    public var id: String
    public var createdAt: String
    public var prefix: String
    public var suffix: String
    public var width: Int
    public var height: Int

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case prefix
        case suffix
        case width
        case height
    }

    public func photoURL(ofSize size: CGSize? = nil) -> URL? {
        let sizeName: String
        if let size = size {
            sizeName = "\(Int(size.width))x\(Int(size.height))"
        } else {
            sizeName = "original"
        }
        return URL(string: prefix.appending(sizeName).appending(suffix))
    }
}

extension Array where Element == IAMNPlacePhoto {
    /// ``IAMNPlacePhoto`` preview data
    public static var preview: [IAMNPlacePhoto] = {
        let data = """
        [
          {
            "id": "61bb8d0b4881bf2a2dd60ba2",
            "created_at": "2021-12-16T19:01:31.000Z",
            "prefix": "https://fastly.4sqi.net/img/general/",
            "suffix": "/47321_Ok47Fu6HxhbyvaVq5Clk5lU03CB6OrDGoa9YNcpaQfY.jpg",
            "width": 1440,
            "height": 1440
          },
          {
            "id": "61b10771908bdc2c21881b11",
            "created_at": "2021-12-08T19:28:49.000Z",
            "prefix": "https://fastly.4sqi.net/img/general/",
            "suffix": "/32_onhv5s32yDVEgq9l7VnVt0h6GEPfrc-LXUIuIGbVfhg.jpg",
            "width": 1920,
            "height": 1125
          },
          {
            "id": "61aa601ffb5e7333bf3730ed",
            "created_at": "2021-12-03T18:21:19.000Z",
            "prefix": "https://fastly.4sqi.net/img/general/",
            "suffix": "/175198_snimtS4WEcYyZOGf6EmoNWi-eOqHOskoi5-T4LR8-hs.jpg",
            "width": 1920,
            "height": 1440
          },
          {
            "id": "61a65140752ed37e4d3f2603",
            "created_at": "2021-11-30T16:28:48.000Z",
            "prefix": "https://fastly.4sqi.net/img/general/",
            "suffix": "/23328650_4fKdbiJ00-xTB7GBsUie5XpTvEk45O0DfraeV1vWUsU.jpg",
            "width": 1440,
            "height": 1920
          },
          {
            "id": "61a651405a9b976f2efb99b0",
            "created_at": "2021-11-30T16:28:48.000Z",
            "prefix": "https://fastly.4sqi.net/img/general/",
            "suffix": "/23328650_kiw8TNqTLlDOIJGz7WI-N59yf5ziDR8syJr6KoATfuY.jpg",
            "width": 1440,
            "height": 1916
          }
        ]
        """.data(using: .utf8)
        guard let data = data else { fatalError("something is wrong with the preview data") }
        let decodedData: Self
        do {
            decodedData = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            fatalError("\(error.localizedDescription); error: \(error)")
        }
        return decodedData
    }()
}
