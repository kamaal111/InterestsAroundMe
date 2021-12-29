//
//  Logger+extensions.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation
import os.log

extension Logger {
    static let homeScreen = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "HomeScreen")
}
