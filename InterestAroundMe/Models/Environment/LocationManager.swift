//
//  LocationManager.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import Foundation
import CoreLocation
import os.log

final class LocationManager: NSObject, ObservableObject {

    @Published private var locationIsAccessible = false

    private let manager = CLLocationManager()

    override init() {
        super.init()

        manager.delegate = self
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch status {
            case .notDetermined, .restricted, .denied:
                self.locationIsAccessible = false
            case .authorizedWhenInUse, .authorizedAlways:
                self.locationIsAccessible = true
            @unknown default:
                Logger.locationManager.warning("unknown location status of \(status.rawValue)")
                self.locationIsAccessible = false
            }
        }
    }
}
