//
//  MockWeatherData.swift
//  AppWeather
//
//  Created by Can Bas on 12/5/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

class MockData {
    static let weatherData = "asdasd"
    static let forecastData = ""
    
    
    static func readJsonWeather() -> Data? {
        do {
            
            guard let fileInBundle = Bundle(for: self).path(forResource: "getWeather", ofType: "json") else {
                return Data()
            }
            return try String(contentsOfFile: fileInBundle).data(using: .utf8)
        } catch {
            print(error)
        }
        
        return Data()
    }
    
    
    static func readJsonForecast() -> Data? {
        do {
            
            guard let fileInBundle = Bundle(for: self).path(forResource: "getForecast", ofType: "json") else {
                return Data()
            }
            return try String(contentsOfFile: fileInBundle).data(using: .utf8)
        } catch {
            print(error)
        }
        
        return Data()
    }
    
    
  
}



