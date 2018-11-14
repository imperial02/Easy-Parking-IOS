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
    func getPins( onSucess: @escaping ([Model]) -> (), onError: @escaping (String) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    
   public func getPins(onSucess: @escaping ([Model]) -> (), onError: @escaping (String) -> ()) {
        
        guard let url = getParkingURL() else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10
        Alamofire.request(urlRequest).responseJSON { [weak self] (response) in
            if let error = response.error {
                onError(error.localizedDescription)
            } else if let jsonValue = response.result.value {
                guard let places = self?.parseJSON(jsonValue) else { return }
                onSucess(places)
            } else {
                onError("unhandled result")
            }
        }
    }
    
    private func getParkingURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = EasyParkingURLConstants.easyParkingSchema
        urlComponents.host = EasyParkingURLConstants.easyParkingApiHost
        urlComponents.path = EasyParkingURLConstants.easyParkingApiPath
        return urlComponents.url
    }
    
    private func parseJSON(_ jsonValue: Any) -> [Model] {
        let json = JSON(jsonValue)
        let placeList = json["location"].arrayValue
        let places = placeList.map { Model(json: $0)}
        return places
    }
    
}
