//
//  IAMNPlaceTip.swift
//  
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation

public struct IAMNPlaceTip: Codable, Hashable, Identifiable {
    public var id: String
    public var createdAt: String
    public var text: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case text
    }
}

extension Array where Element == IAMNPlaceTip {
    /// ``IAMNPlaceTip`` preview data
    public static let preview: [IAMNPlaceTip] = {
        let data = """
[
  {
    "id": "5b18217dd69ed0002c57ffaf",
    "created_at": "2018-06-06T18:01:33.000Z",
    "text": "The Library is great for quiet work"
  },
  {
    "id": "5b6cc5756fd626002db9b7c6",
    "created_at": "2018-08-09T22:51:33.000Z",
    "text": "The location intelligence is great here."
  },
  {
    "id": "5b1eb04a48b04e002c5e9eb9",
    "created_at": "2018-06-11T17:24:26.000Z",
    "text": "The boardroom is very long"
  },
  {
    "id": "5b1eaee5838e59002c5f6539",
    "created_at": "2018-06-11T17:18:29.000Z",
    "text": "There’s a book in the library."
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
