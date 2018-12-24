//
//  StringExtension.swift
//  AppWeather
//
//  Created by Can Bas on 12/20/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

