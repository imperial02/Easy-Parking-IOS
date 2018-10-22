//
//  Model.swift
//  Easy - Parking
//
//  Created by Любчик on 9/30/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import SwiftyJSON
import CoreLocation
import Foundation

struct Model {
    
    let lat: String?
    let lng: String?
    let locationID: Int?
    let name: String?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = Double(lat ?? "0")
            , let lon = Double(lng ?? "0") else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    init(json: JSON) {
        lat = json["lat"].stringValue
        lng = json["lng"].stringValue
        name = json["name"].stringValue
        locationID = json["location_id"].intValue
    }
    
    var jsonValue: JSON {
        let dict: [String: Any] = [
            "lat": lat ?? JSON.null,
            "name": name ?? JSON.null,
            "lng": lng ?? JSON.null,
            "location_id": locationID ?? JSON.null
        ]
        return JSON(dict)
    }
    
}
