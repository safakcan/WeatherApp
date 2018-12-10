//
//  AppWeatherTests.swift
//  AppWeatherTests
//
//  Created by Can Bas on 11/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import XCTest
@testable import AppWeather

class AppWeatherTests: XCTestCase {
    
     let weatherData = MockData.readJsonWeather()
     let forecastData = MockData.readJsonForecast()
    
    let locationName = "Afif"
    let lat = 24.02
    let long = 42.200000000000003
    let humidity = 43
    let temp = 24.14
    
    func testParseWeatherData_NotNil() {
    
        if let data = weatherData {
            let testWeatherParser = JSONParser.parseWeather(data: data)
            XCTAssertNotNil(testWeatherParser)
        }
    }
    
    func testParseWeatherData_cityName() {
        
        if let data = weatherData {
            let testWeatherParser = JSONParser.parseWeather(data: data)
            XCTAssertEqual(testWeatherParser.name, locationName)
        }
    }
    
    func testParseWeatherData_locationCorrect() {
        
        if let data = weatherData {
            let testWeatherParser = JSONParser.parseWeather(data: data)
            XCTAssertEqual(testWeatherParser.latitude, lat)
            XCTAssertEqual(testWeatherParser.longitude, long)
        }
    }
    
    func testParseWeatherData_locationWrong() {

        if let data = weatherData {
            let testWeatherParser = JSONParser.parseWeather(data: data)
            XCTAssertNotEqual(testWeatherParser.latitude, 20.0)
        }
    }
    
        func testParseForecastData_NotNil() {
            
            if let data = forecastData {
                let testForecastParser = JSONParser.parseForecast(data: data)
                XCTAssertNotNil(testForecastParser)
            }
        }
    func testParseForecastData_HumidityCheck() {
        
        if let data = forecastData {
            let testForecastParser = JSONParser.parseForecast(data: data)
            XCTAssertEqual(testForecastParser.first?.humidity, humidity)
        }
    }
    func testParseForecastData_TempCheck() {
        
        if let data = forecastData {
            let testForecastParser = JSONParser.parseForecast(data: data)
            XCTAssertEqual(testForecastParser.first?.temp, temp)
        }
      }
    }

