//
//  Weather.swift
//  AppWeather
//
//  Created by Can Bas on 11/13/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

class Weather {
    
    var latitude: Double!
    var longitude: Double!
    var icon: String?
    var temp: Double?
    var name: String?
    var image: Data?
    
    init(latitude: Double, longitude: Double, icon: String? = nil, temp: Double? = nil, name: String? = nil, image: Data? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.icon = icon
        self.temp = temp
        self.name = name
        self.image = image
    }
    
}
