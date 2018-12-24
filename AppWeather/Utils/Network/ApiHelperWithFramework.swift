//
//  ApiHandlerWithFramework.swift
//  AppWeather
//
//  Created by Can Bas on 12/10/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import Alamofire

class ApiHelperWithFramework: ApiHandler {

    func fetchWeatherData(lat: Double, long: Double, apiCallType: ApiCallType, callback: @escaping ((Weather) -> Void)) {
        let tempQuery = AppWeatherUtils.buildURL(weather: Weather(latitude: lat, longitude: long), apiCallType: apiCallType)
        Alamofire.request(tempQuery).responseData { (response) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    let weather: Weather = JSONParser.parseWeather(data: data)
                    callback(weather)
                }
                break

            case .failure(_):
                break
            }
        }
    }

    func fetchForecastData (lat: Double, long: Double, apiCallType: ApiCallType, callback: @escaping (([FutureWeather]) -> Void)) {
        let tempQuery = AppWeatherUtils.buildURL(weather: Weather(latitude: lat, longitude: long), apiCallType: apiCallType)
        Alamofire.request(tempQuery).responseData { (response) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    let forecastArray: [FutureWeather] = JSONParser.parseForecast(data: data)
                    callback(forecastArray)
                }
                break

            case .failure(_):
                break
            }
        }
    }
}
