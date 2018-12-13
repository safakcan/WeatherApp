//
//  SettingsViewController.swift
//  AppWeather
//
//  Created by Can Bas on 12/13/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func tempSwitch(_ sender: UISwitch) {
        Settings.callTypeWeather = sender.isOn ? ApiCallType.weatherWithFahrenheit : ApiCallType.weatherWithCelcius
        Settings.callTypeForecast = sender.isOn ? ApiCallType.forecastWithFahrenheit : ApiCallType.forecastWithCelcius
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
