//
//  SettingsViewController.swift
//  AppWeather
//
//  Created by Can Bas on 12/13/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit

enum TemperatureUnit: String {
    case celcius = "metric"
    case fahrenheit = "imperial"
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var unitSwitch: UISwitch!
    
    @IBAction func tempSwitch(_ sender: UISwitch) {

        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn ? TemperatureUnit.fahrenheit.rawValue:
        TemperatureUnit.celcius.rawValue, forKey: "unit")
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        let unit = userDefaults.string(forKey: "unit") ?? TemperatureUnit.celcius.rawValue
        unitSwitch.isOn = unit != TemperatureUnit.celcius.rawValue
    }
    
}
