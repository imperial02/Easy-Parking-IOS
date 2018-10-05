//
//  NetworkManager.swift
//  Easy - Parking
//
//  Created by Любчик on 9/30/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol NetworkManagerProtocol {
    func getPins( onSucess: @escaping ([Model]) -> (), onError: @escaping (Error) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    private func getParkingURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = EasyParkingURLConstants.easyParkingSchema
        urlComponents.host = EasyParkingURLConstants.easyParkingApiHost
        urlComponents.path = EasyParkingURLConstants.easyParkingApiPath
        return urlComponents.url
    }
    
    func getPins(onSucess: @escaping ([Model]) -> (), onError: @escaping (Error) -> ()) {
        
        guard let url = getParkingURL() else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10
        Alamofire.request(urlRequest).responseJSON { [weak self] (response) in
            if let error = response.error {
                onError(error)
            } else {
                DispatchQueue.main.async {
                    
                    guard let jsonData = response.value else { return }
                    guard let models = self?.parseResponce(jsonData: jsonData) else { return }
                    onSucess(models)
                }
            }
        }
    }
    
    private func parseResponce(jsonData: Any) -> [Model] {
        let jsonValue = JSON(jsonData)
        let locations = jsonValue["location"].arrayValue
        var models = [Model]()
        for location in locations {
            let name = location["name"].stringValue
            let location_id = location["location_id"].intValue
            let lng = location["lng"].doubleValue
            let lat = location["lat"].doubleValue
            models.append(Model(lat: lat, lng: lng, locationID: location_id, name: name))
        }
        return models
    }
    
}
