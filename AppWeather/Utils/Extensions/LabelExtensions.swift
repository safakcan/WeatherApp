//
//  LabelExtensions.swift
//  AppWeather
//
//  Created by Can Bas on 12/20/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var localizedString: String {
        set {
            text = newValue.localized
        }
        get {
            return self.localizedString
        }
    }
}
