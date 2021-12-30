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

    @Published private(set) var error: Errors?
    @Published private(set) var userLocation: CLLocation?
    @Published private(set) var locationIsAccessible = false

    private let manager = CLLocationManager()

    override init() {
        super.init()

        manager.delegate = self
    }

    enum Errors: Error, LocalizedError {
        case generalError

        var errorDescription: String {
            switch self {
            case .generalError: return "Something went wrong while getting your location"
            }
        }
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    private func handleLocationAuthorized() {
        DispatchQueue.main.async { [weak self] in
            self?.locationIsAccessible = true
        }
        manager.startUpdatingLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !Features.loadUserLocationOnce || userLocation == nil else { return }
        guard let location = locations.last else { return }

        DispatchQueue.main.async { [weak self] in
            self?.userLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.error = .generalError
        }
        Logger.locationManager.warning(
            "something went wrong in the location manager; error: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch status {
            case .notDetermined, .restricted, .denied: self.locationIsAccessible = false
            case .authorizedWhenInUse, .authorizedAlways: self.handleLocationAuthorized()
            @unknown default:
                Logger.locationManager.warning("unknown location status of \(status.rawValue)")
                self.locationIsAccessible = false
            }
        }
    }
}
