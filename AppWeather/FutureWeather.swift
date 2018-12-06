//
//  FutureWeather.swift
//  AppWeather
//
//  Created by Can Bas on 11/26/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

class FutureWeather {
    
    var date: String?
    var image: Data?
    var temp: Double?
    var humidity : Int?
    var wind: Double?
    var rain: Double?
    
    init(date: String? = nil, image: Data? = nil, temp: Double? = nil, humidity: Int? = nil, wind: Double? = nil, rain: Double? = nil) {
        self.date = date
        self.image = image
        self.temp = temp
        self.humidity = humidity
        self.wind = wind
        self.rain = rain
    }
}
