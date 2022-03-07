//
//  NetworkManager.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import Foundation
import Alamofire
import AlamofireMapper

class NetworkManager {
    
    //MARK:- getImagesList
    public func getLaunchesList(successCompletion: @escaping ((_ json : Launches) -> Void)) {
     let url = "https://api.spacexdata.com/v2/launches"
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<Launches>) in
            switch response.result {
            case .success(let json):
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
           
        }
    }
    
// https://api.spacexdata.com/v4/launches?2006
    public func getLaunchesListWithYear(year: String, successCompletion: @escaping ((_ json : Launches) -> Void)) {
     let url = "https://api.spacexdata.com/v2/launches?"+year
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<Launches>) in
            switch response.result {
            case .success(let json):
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
           
        }
    }
    
}
