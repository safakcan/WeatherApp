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

class ApiHelper: ApiHandler {
    
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
    
    func fetchForecastData (lat: Double, long: Double, apiCallType: ApiCallType , callback: @escaping (([FutureWeather])->Void)){
        
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
    
}
