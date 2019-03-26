//
//  ButtonExtensions.swift
//  AppWeather
//
//  Created by Can Bas on 12/20/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var localizedString: String {
        set {
            setTitle(newValue.localized, for: .normal)
        }
        get {
            guard let titleLabel = titleLabel, let text = titleLabel.text else {
                return ""
            }
            return text
        }
    }
}
