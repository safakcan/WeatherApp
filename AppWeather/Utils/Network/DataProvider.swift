//
//  DataProvider.swift
//  AppWeather
//
//  Created by Can Bas on 12/10/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation


class DataProvider {
    
    var apiHandler: ApiHandler
    
    init(apiHandler: ApiHandler) {
        self.apiHandler = apiHandler
    }
    
    func getWeatherData(lat: Double, lon: Double, apiCallType: ApiCallType, callBack: @escaping ((Weather) -> Void)){
        apiHandler.fetchWeatherData(lat: lat, long: lon, apiCallType: apiCallType) { weather in
            callBack(weather)
        }
    }
    
    func getForecastData(lat: Double, long: Double, apiCallType: ApiCallType , callback: @escaping (([FutureWeather])->Void)){
        apiHandler.fetchForecastData(lat: lat, long: long, apiCallType: apiCallType) { (forecastedWeather) in
            callback(forecastedWeather)
        }
    }
    
}
