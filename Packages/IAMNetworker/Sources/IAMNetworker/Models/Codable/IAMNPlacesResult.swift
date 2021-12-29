//
//  IAMNPlacesResult.swift
//  
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation

public struct IAMNPlacesResult: Codable, Hashable {
    public var results: [IAMNPlace]
}

public struct IAMNPlace: Codable, Hashable, Identifiable {
    public var id: String
    public var categories: [IAMNPlaceCategory]
    public var distance: Int
    public var geocodes: IAMNGeocodes
    public var location: IAMNLocation
    public var name: String
    public var relatedPlaces: IAMNRelatedPlaces
    public var timezone: String

    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case categories
        case distance
        case geocodes
        case location
        case name
        case relatedPlaces = "related_places"
        case timezone
    }
}

public struct IAMNPlaceCategory: Codable, Hashable, Identifiable {
    public var id: Int
    public var name: String
    public var icon: IAMNPlaceCategoryIcon
}

public struct IAMNPlaceCategoryIcon: Codable, Hashable {
    public var prefix: String
    public var suffix: String

    public enum IconSizes: Int {
        case extraSmall = 32
        case small = 44
        case medium = 64
        case large = 88
        case extraLarge = 120
    }

    public func iconURL(ofSize size: IconSizes) -> URL? {
        URL(string: "\(prefix)bg_\(size.rawValue)\(suffix)")
    }
}

public struct IAMNGeocodes: Codable, Hashable {
    public var frontDoor: IAMNGeocode?
    public var main: IAMNGeocode

    enum CodingKeys: String, CodingKey {
        case frontDoor = "front_door"
        case main
    }
}

public struct IAMNGeocode: Codable, Hashable {
    public var latitude: Double
    public var longitude: Double
}

public struct IAMNLocation: Codable, Hashable {
    public var address: String
    public var country: String
    public var crossStreet: String
    public var dma: String
    public var locality: String
    public var neighborhood: [String]
    public var postcode: String
    public var region: String

    enum CodingKeys: String, CodingKey {
        case address
        case country
        case crossStreet = "cross_street"
        case dma
        case locality
        case neighborhood
        case postcode
        case region
    }
}

public struct IAMNRelatedPlaces: Codable, Hashable { }

extension IAMNPlacesResult {
    public static let preview: Self = {
        let data = """
{
  "results": [
    {
      "fsq_id": "4b1d54baf964a520df0e24e3",
      "categories": [
        {
          "id": 19014,
          "name": "Hotel",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/travel/hotel_",
            "suffix": ".png"
          }
        }
      ],
      "chains": [],
      "distance": 7,
      "geocodes": {
        "front_door": {
          "latitude": 41.878069,
          "longitude": -87.629958
        },
        "main": {
          "latitude": 41.87807820817222,
          "longitude": -87.62988455145785
        }
      },
      "location": {
        "address": "65 W Jackson Blvd",
        "country": "US",
        "cross_street": "at S Federal St",
        "dma": "Chicago",
        "locality": "Chicago",
        "neighborhood": [
          "Loop"
        ],
        "postcode": "60604",
        "region": "IL"
      },
      "name": "Union League Club Of Chicago",
      "related_places": {
        "children": []
      },
      "timezone": "America/Chicago"
    },
    {
      "fsq_id": "5de83a0e3e332c0008157c92",
      "categories": [
        {
          "id": 11130,
          "name": "Office Building",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/building/default_",
            "suffix": ".png"
          }
        }
      ],
      "chains": [],
      "distance": 1,
      "geocodes": {
        "main": {
          "latitude": 41.878092,
          "longitude": -87.629779
        }
      },
      "location": {
        "address": "53 W Jackson Blvd",
        "country": "US",
        "cross_street": "",
        "dma": "Chicago",
        "locality": "Chicago",
        "neighborhood": [
          "Loop"
        ],
        "postcode": "60604",
        "region": "IL"
      },
      "name": "53 W Jackson",
      "related_places": {},
      "timezone": "America/Chicago"
    },
    {
      "fsq_id": "4b83f6b5f964a520ab1831e3",
      "categories": [
        {
          "id": 13001,
          "name": "Bagel Shop",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/bagels_",
            "suffix": ".png"
          }
        }
      ],
      "chains": [
        {
          "id": "2cb519f8-883c-4263-860a-cd83325fbb97",
          "name": "Dunkin'"
        }
      ],
      "distance": 58,
      "geocodes": {
        "front_door": {
          "latitude": 41.878074,
          "longitude": -87.629148
        },
        "main": {
          "latitude": 41.87802405366788,
          "longitude": -87.62910124854324
        }
      },
      "location": {
        "address": "39 W Jackson Blvd",
        "country": "US",
        "cross_street": "at S Dearborn St",
        "dma": "Chicago",
        "locality": "Chicago",
        "neighborhood": [
          "Loop"
        ],
        "postcode": "60604",
        "region": "IL"
      },
      "name": "Dunkin'",
      "related_places": {},
      "timezone": "America/Chicago"
    },
    {
      "fsq_id": "50fae393e4b01b267a6148be",
      "categories": [
        {
          "id": 18075,
          "name": "Swimming Pool",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/parks_outdoors/pool_",
            "suffix": ".png"
          }
        }
      ],
      "chains": [],
      "distance": 20,
      "geocodes": {
        "main": {
          "latitude": 41.878105022245755,
          "longitude": -87.62955818047078
        }
      },
      "location": {
        "address": "65 W Jackson Blvd",
        "country": "US",
        "cross_street": "",
        "dma": "Chicago",
        "locality": "Chicago",
        "neighborhood": [
          "Loop"
        ],
        "postcode": "60604",
        "region": "IL"
      },
      "name": "Union League of Chicago Pool",
      "related_places": {},
      "timezone": "America/Chicago"
    },
    {
      "fsq_id": "49d51ce3f964a520675c1fe3",
      "categories": [
        {
          "id": 13031,
          "name": "Burger Joint",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/burger_",
            "suffix": ".png"
          }
        },
        {
          "id": 13035,
          "name": "Coffee Shop",
          "icon": {
            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/coffeeshop_",
            "suffix": ".png"
          }
        }
      ],
      "chains": [],
      "distance": 15,
      "geocodes": {
        "main": {
          "latitude": 41.87809169951115,
          "longitude": -87.62961497685731
        }
      },
      "location": {
        "address": "53 W Jackson Blvd",
        "country": "US",
        "cross_street": "at S Dearborn St",
        "dma": "Chicago",
        "locality": "Chicago",
        "neighborhood": [
          "Loop"
        ],
        "postcode": "60604",
        "region": "IL"
      },
      "name": "Intelligentsia Coffee",
      "related_places": {
        "parent": {
          "fsq_id": "4bfbd2aabbb7c928ea970843",
          "name": "Monadnock Building"
        }
      },
      "timezone": "America/Chicago"
    }
  ]
}
""".data(using: .utf8)
        guard let data = data, let decodedData = try? JSONDecoder().decode(Self.self, from: data) else {
            fatalError("something is wrong with the preview data")
        }
        return decodedData
    }()
}
