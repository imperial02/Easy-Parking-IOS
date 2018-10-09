//
//  ViewController.swift
//  Easy - Parking
//
//  Created by Любчик on 9/16/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

final class MapViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: GMSMapView!
    
    // MARK: - Variables
    private let camera = GMSCameraPosition.camera(withLatitude: 49.8383, longitude: 24.0232, zoom: 10.0)
    private let locationManager = LocationManager()
    private let networkManager = NetworkManager()
    private var model: [Model] = []
    private var dataSource: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = false
        fetchData()
    }
    
    // MARK: - IBAction
    @IBAction func searchLocation(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
    // MARK: - Private
    private func presentNoLocationController() {
        guard let viewController = UIStoryboard(name: Constants.storyboardName, bundle: nil).instantiateViewController(withIdentifier: Constants.noLocationControllerStoryboardIdentifier   ) as? NoLocationViewController else { return }
        guard let navigator = navigationController else { return }
        navigator.present(viewController, animated: true)
    }
    
    private func fetchData() {
        DispatchQueue.main.async {
            self.networkManager.getPins(onSucess: { [weak self] model in
                self?.model = model
                self?.createAnnotations(for: model)
                print(model)
            }) { [weak self] (error) in
                guard let `self` = self else { return }
                AlertHelper.showAlert(on: self, message: "Fuck", buttonTitle: "Ok", buttonAction: { })
            }
        }
    }
    
    private func createAnnotations(for parkingPlaces: [Model]) {
        parkingPlaces.forEach {
            let marker = ParkingPins(parkingPlaces: $0)
            marker.map = mapView
        }
    }
    
}

// MARK: - LocationManagerDelegate
extension MapViewController: LocationManagerDelegate {
    
    func didChange(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not determined")
        case .restricted,.denied:
            presentNoLocationController()
        case .authorizedAlways, .authorizedWhenInUse:
            navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func didReceiveUserLocation(_ location: CLLocation) {
        print("\(location)")
    }
    
    func didReceiveError(_ error: Error) {
        print("\(error.localizedDescription)")
    }
    
    func showAlertForRestrictedCase() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            AlertHelper.showAlert(on: self, title: Constants.restrictedAlertTitle,
                                  message: Constants.restrictedAlertMessage,
                                  buttonTitle: Constants.restrictedAlertButtonName,
                                  buttonAction: { guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
                                    UIApplication.shared.open(settingsUrl)
            }, showCancelButton: false)
        }
    }
    
}

//MARK: - GMSAutocompleteViewControllerDelegate
extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress as Any)
        print("Place attributions: ", place.attributions as Any)
        print("Place Latitude: ", place.coordinate.latitude)
        print("Place Longitude: ", place.coordinate.longitude)
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) 
    }
    
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

//MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("hello")
        return true
    }
    
}
