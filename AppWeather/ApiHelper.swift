//
//  JSONParser.swift
//  AppWeather
//
//  Created by Can Bas on 11/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//
//protocol ApiHandler {
//    func getWeather() -> String
//    func getForecast() -> String
//}
//
//class ApiWithAlamofire: ApiHandler {
//    func getWeather() -> String {
//        return "ali"
//    }
//
//    func getForecast() -> String {
//        return "veli"
//    }
//
//}
//
//
//class ApiWithHardCoded: ApiHandler {
//    func getWeather() -> String {
//        return "ayşe"
//    }
//
//    func getForecast() -> String {
//        return "fatma"
//    }
//}
//
//class DataProvider {
//    var apiHandler: ApiHandler
//
//    init(apiHandler: ApiHandler) {
//        self.apiHandler = apiHandler
//    }
//
//    func deneme() {
//        apiHandler.getWeather()
//    }
//}


class ApiHelper {
    var isCelcius = true
    var JSONUnit:String = ""
    var degreeText = ""
    var cityName = ""
    var weatherImage = UIImage(named: "")
    var rain = 0.0
    
    func fetchWeatherData (lat: Double, long: Double, apiCallType: ApiCallType , callback: @escaping ((Weather)->Void)) {
      
        let tempQuery = AppWeatherUtils.buildURL(weather: Weather(latitude: lat, longitude: long), apiCallType: apiCallType)
          let url = URL(string: tempQuery)
        URLSession.shared.dataTask(with:url!) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                
                    let weather: Weather = JSONParser.parseWeather( data: data!)
                    callback(weather)
                }
            }.resume()
    }
    
    func fetchForecast(lat: Double, long: Double, apiCallType: ApiCallType , callback: @escaping (([FutureWeather])->Void)){
        
        let tempQuery = AppWeatherUtils.buildURL(weather: Weather(latitude: lat, longitude: long), apiCallType: apiCallType)
        let url = URL(string: tempQuery)
        URLSession.shared.dataTask(with:url!) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                
                let forecastArray: [FutureWeather] = JSONParser.parseForecast(data: data!)
                callback(forecastArray)
                
                }
            }.resume()
    }
    
//    func fetchWeather() {
//        Alamofire.request("asd").responseData { (response) in
//            
//        }
//        Alamofire.request("https://yourServiceURL.com", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
//
//            switch(response.result) {
//            case .success(_):
//                if let data = response.result.value{
//                    print(response.result.value)
//                }
//                break
//
//            case .failure(_):
//                print(response.result.error)
//                break
//
//            }
//        }
//    }
}
