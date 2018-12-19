//
//  RatingControl.swift
//  AppWeather
//
//  Created by Can Bas on 12/11/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit
import StoreKit

class PopupViewController: UIViewController {

    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet var starButtons: [UIButton]!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 10
    }
    
    // MARK: Actions
    
    @IBAction func exitTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

