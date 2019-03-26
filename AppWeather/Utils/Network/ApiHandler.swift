//
//  ApiHandler.swift
//  AppWeather
//
//  Created by Can Bas on 12/10/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

protocol ApiHandler {

    func fetchWeatherData(lat: Double, long: Double, apiCallType: ApiCallType, callback: @escaping ((Weather) -> Void))

    func fetchForecastData(lat: Double, long: Double, apiCallType: ApiCallType, callback: @escaping (([FutureWeather]) -> Void))
}
