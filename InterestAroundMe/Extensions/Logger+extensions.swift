//
//  Logger+extensions.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import Foundation
import os.log

extension Logger {
    private static let bundleIdentifier = Bundle.main.bundleIdentifier!

    static let homeScreen = Logger(subsystem: bundleIdentifier, category: "HomeScreen")
    static let locationManager = Logger(subsystem: bundleIdentifier, category: "LocationManager")
}
