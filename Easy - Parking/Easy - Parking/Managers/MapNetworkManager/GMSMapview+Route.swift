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

//MARK: - GMSMapView+RouteExtension 
extension GMSMapView {
    func drawPath(googleMaps: GMSMapView ,startLocation: CLLocation, endLocation: CLLocation)
    {
        var polylines = [GMSPolyline]()
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        guard let url = getGoogleUrl(startLocation: origin, endLocation: destination) else { return }
        Async.mainQueue {
            Alamofire.request(url).responseJSON { response in
                if let error = response.error {
                    print(error.localizedDescription)
                } else if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    let routes = json["routes"].arrayValue
                    for route in routes {
                        let routeOverviewPolyline = route["overview_polyline"].dictionary
                        let points = routeOverviewPolyline?["points"]?.stringValue
                        let path = GMSPath.init(fromEncodedPath: points!)
                        let polyline = GMSPolyline.init(path: path)
                        polylines.append(polyline)
                        polyline.strokeWidth = 4
                        polyline.strokeColor = UIColor(red: 200, green: 100 , blue: 3, alpha: 1.0)
                        polyline.map = googleMaps
                        if polylines.count > 1 || endLocation == startLocation {
                            polylines.removeLast()
                        }
                    }
                }
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

