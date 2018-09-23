//
//  LocationManager.swift
//  Easy - Parking
//
//  Created by Любчик on 9/23/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Foundation
import CoreLocation

enum PermissionState: String {
    case notDetermined
    case authorized
    case denied
    case restricted
}

protocol LocationManagerDelegate: class {
    func didReceiveUserLocation(_ location: CLLocation)
    func didReceiveError(_ error: Error)
    func showAlertForRestrictedCase()
}

class LocationManager: NSObject {
    
    // MARK: - Variables
    private let locationManager = CLLocationManager()
    private weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        askUserForLocationAccess()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Private
    final private func askUserForLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            print(PermissionState.notDetermined.rawValue)
        case .restricted:
            print(PermissionState.restricted.rawValue)
            self.delegate?.showAlertForRestrictedCase()
        case .denied:
            print(PermissionState.denied.rawValue)
        case .authorizedAlways,.authorizedWhenInUse:
            print(PermissionState.authorized.rawValue)
        }
    }
    
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentUserLocation = locations.last else { return }
        self.delegate?.didReceiveUserLocation(currentUserLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error.localizedDescription)
        self.delegate?.didReceiveError(error)
    }
    
}
