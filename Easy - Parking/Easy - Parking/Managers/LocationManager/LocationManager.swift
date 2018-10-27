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

enum RegionState: String {
    case unknown
    case inside
    case outside
}

protocol LocationManagerDelegate: class {
    func didReceiveUserLocation(_ location: CLLocation)
    func didReceiveError(_ error: Error)
    func showAlertForRestrictedCase()
    func didChange(status : CLAuthorizationStatus)
}

class LocationManager: NSObject {
    
    // MARK: - Variables
    private let locationManager = CLLocationManager()
    private let notificationManager = NotificationManager()
    weak var delegate: LocationManagerDelegate?
    private var markerCoordinate: CLLocation? {
        didSet {
            guard let coordinate = markerCoordinate else { return }
            let center = CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
            let markerRegion = CLCircularRegion(center: center, radius: RegionConstants.radius, identifier: RegionConstants.regionIdentifier)
            markerRegion.notifyOnEntry = true
            locationManager.startMonitoring(for: markerRegion)
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        askUserForLocationAccess()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Private
     private func askUserForLocationAccess() {
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
    
    final func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentUserLocation = locations.last else { return }
        self.delegate?.didReceiveUserLocation(currentUserLocation)
    }
    
    final func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error.localizedDescription)
        self.delegate?.didReceiveError(error)
    }
    
    final func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.delegate?.didChange(status: status)
    }
    
    final func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        locationManager.requestState(for: region)
        print("Monitoring \(region.identifier)")
    }
    
    final func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        guard let currentRegion = region else { return }
        locationManager.stopMonitoring(for: currentRegion)
        print(error.localizedDescription)
    }
    
    final func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .unknown:
            print(RegionState.unknown.rawValue)
        case .inside:
            print(RegionState.inside.rawValue)
        case .outside:
            print(RegionState.outside.rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        locationManager.stopMonitoring(for: region)
        print("Stop monitoring for \(region)")
    }
    
    final func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        locationManager.startMonitoring(for: region)
        notificationManager.showNotification()
    }
    
}

extension LocationManager: MapManagerDelegate {
    func didReceivePinCoordinate(_ location: CLLocation) {
        Async.mainQueue { [weak self] in
            self?.markerCoordinate = location
        }
    }
}

