//
//  Array+extensions.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation

extension Array {
    var commaSperated: String {
        var string = ""
        for (index, element) in self.enumerated() {
            string.append("\(element)")
            if index < self.count - 1 {
                string.append(",")
            }
        }
        return string
    }
}
