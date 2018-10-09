//
//  ParkingPins.swift
//  Easy - Parking
//
//  Created by Любчик on 10/9/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Foundation
import GoogleMaps

class ParkingPins: GMSMarker {
    var places: Model?
    
    init (parkingPlaces: Model) {
        super.init()
        self.places = parkingPlaces
        if let coordinate = places?.coordinate {
            position = coordinate
        }
    }
}
