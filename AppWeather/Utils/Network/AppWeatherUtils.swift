//
//  AppWeatherUtils.swift
//  AppWeather
//
//  Created by Can Bas on 11/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

enum ApiCallType: String {
    case forecast
    case weather
}

class AppWeatherUtils {
    
    static var baseURL = "http://api.openweathermap.org/data/2.5/"
    static var apiKey:String = "a726ccf4a41cfbb58b0b184dec81d7d9"
    static var concatinate = ""
    static var lang = "&lang=eng"
    // rest of the url will change -> weather?lat=41&lon=28.97&appid=
    
    static func buildURL(weather: Weather, apiCallType: ApiCallType ) -> String {
        let userDefaults = UserDefaults.standard
        let unit = userDefaults.string(forKey: UserdefaultStrings.unit.rawValue) ?? TemperatureUnit.celcius.rawValue
        if Bundle.main.preferredLocalizations.first == "en" {
            lang = "&lang=eng"
        } else {
            lang = "&lang=tr"
        }
        
        switch apiCallType {
        case .forecast:
            concatinate = baseURL + "forecast?" + "units=" + unit + "&lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + lang + "&appid="
        case .weather:
            concatinate = baseURL + "weather?" + "units=" + unit + "&lat=" + String(weather.latitude) + "&" + "lon=" + String(weather.longitude) + lang + "&appid="
        }
        
        return concatinate + apiKey
    }
    
}
