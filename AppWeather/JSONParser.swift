//
//  JSONParser.swift
//  AppWeather
//
//  Created by Can Bas on 12/5/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

class JSONParser {
    
    static func parseWeather(data: Data) -> Weather {
        var localCondition = Double()
        var locationName = ""
        var weatherIcon = ""
        var weatherConditions = [[String:Any]]()
        var currentConditions = [String:Any]()
        var image :Data?
        var lat = 0.0
        var lon = 0.0
        do{
        var parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
    
            var coord = parsedData["coord"] as! [String:Any]
            weatherConditions = parsedData["weather"] as! [[String:Any]]
            currentConditions = parsedData["main"] as! [String:Any]
            locationName = parsedData["name"] as! String
            weatherIcon = weatherConditions[0]["icon"] as! String
            localCondition = currentConditions["temp"] as! Double
            lat = coord["lat"] as! Double
            lon = coord["lon"] as! Double
            
           
            
            let imageBaseURL = "http://openweathermap.org/img/w/"
            let imageURL = URL(string: imageBaseURL + weatherIcon + ".png")
            image = try? Data(contentsOf: imageURL!)
            
            
        }catch let error as NSError {
            print(error)
        }
        
        return Weather(latitude: lat, longitude: lon, icon: weatherIcon, temp: localCondition, name: locationName, image: image)
    }
    
    static func parseForecast(data: Data) -> [FutureWeather]  {
        var currentConditions = [String:Any]()
        var futureWeather: FutureWeather?
        var futureWeatherArray: [FutureWeather] = []
        var image:Data?
        var rain = 0.0
  
        
        do {
            var parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let forecastList = parsedData["list"] as! [[String:Any]]
          
            var index = 0
            
            while index < forecastList.count {
                
                var mainDetail = forecastList[index]["main"] as! [String:Any]
                var weatherDetail = forecastList[index]["weather"] as![[String:Any]]
                let date = forecastList[index]["dt_txt"] as! String
                let iconDetail = weatherDetail[0]["icon"] as! String
                let degreeDetail = mainDetail["temp"] as! Double
                var windConditions = forecastList[0]["wind"] as! [String:Any]
                currentConditions = forecastList[0]["main"] as! [String:Any]
                
                let humidity = currentConditions["humidity"] as! Int
                let windSpeed = windConditions["speed"] as! Double
                
                if let rainConditions = forecastList[0]["rain"] as? [String:Any]{
                    
                    if checkIfNil(condition: rainConditions) == true {
                        rain = rainConditions["3h"] as! Double
                    }else{
                        rain = 0.0
                    }
                }
                
                let imageBaseURL = "http://openweathermap.org/img/w/"
                let imageURL = URL(string: imageBaseURL + iconDetail + ".png")
                image = try? Data(contentsOf: imageURL!)
                
                
                    futureWeather = FutureWeather(date: date, image: image, temp: degreeDetail,humidity: humidity, wind:windSpeed, rain: rain)
                    futureWeatherArray.append(futureWeather!)
                    
                    
                    if index + 8 >= forecastList.count {
                        break
                    }
                index = index + 8
            }
        }catch let error as NSError {
            print(error)
        }
        return futureWeatherArray
    }
    
    static func checkIfNil(condition: [String:Any]) -> Bool{
        if condition.count == 0 {
            return false
        }else{
            return true
        }
    }
    
}
