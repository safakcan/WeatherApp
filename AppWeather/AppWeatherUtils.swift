//
//  AppWeatherUtils.swift
//  AppWeather
//
//  Created by Can Bas on 11/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

enum ApiCallType: String {
    case forecastWithCelcius
    case forecastWithFahrenheit
    case weatherWithCelcius
    case weatherWithFahrenheit
}

class AppWeatherUtils {
    
    static var baseURL = "http://api.openweathermap.org/data/2.5/"
    static var apiKey:String = "a726ccf4a41cfbb58b0b184dec81d7d9"
    static var concatinate = ""
    // rest of the url will change -> weather?lat=41&lon=28.97&appid=
    
    static func buildURL(weather: Weather, apiCallType: ApiCallType ) -> String {
        
        switch apiCallType {
        case .forecastWithCelcius:
            concatinate = baseURL + "forecast?" + "units=metric&" + "lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + "&appid="
        case .forecastWithFahrenheit:
             concatinate = baseURL + "forecast?" + "lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + "&appid="
        case .weatherWithCelcius:
            concatinate = baseURL + "weather?"+"units=metric&" + "lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + "&appid="
        case .weatherWithFahrenheit:
            concatinate = baseURL + "weather?" + "lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + "&appid="
            
        }
        return concatinate + apiKey
    }
}
