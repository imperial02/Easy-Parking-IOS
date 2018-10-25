//
//  GMSMapview+Route.swift
//  Easy - Parking
//
//  Created by Любчик on 10/25/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import CoreLocation
import Foundation
import SwiftyJSON
import Alamofire
import GoogleMaps
import GooglePlaces

extension GMSMapView {
    func drawPath(googleMaps: GMSMapView ,startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        guard let url = getGoogleUrl(startLocation: origin, endLocation: destination) else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            if let error = response.error {
                print(error.localizedDescription)
            } else if let jsonValue = response.result.value {
                let json = JSON(jsonValue)
                let routes = json["routes"].arrayValue
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = googleMaps
                }
            } else {
                print("Smth goes wrong")
            }
             
        }
    }
    
    private func getGoogleUrl(startLocation: String, endLocation: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = GoogleConstants.googleSchema
        urlComponents.host = GoogleConstants.googleHost
        urlComponents.path = GoogleConstants.googlePath
        urlComponents.queryItems = [
        URLQueryItem(name: JSONParameters.origin, value: startLocation),
        URLQueryItem(name: JSONParameters.destination, value: endLocation),
        URLQueryItem(name: JSONParameters.mode, value: JSONParameters.drivingMode),
        URLQueryItem(name: JSONParameters.key, value: Constants.googleApiKey)
        ]
       return urlComponents.url
    }
}

