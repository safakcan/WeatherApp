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
    
    @IBAction func exitTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        for index in 0...starButtons.count-1 {
                starButtons[index].setTitle("☆", for: .normal)
            if sender == starButtons[index] {
                for button in 0...index {
                    starButtons[button].setTitle("★", for: .normal)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
           SKStoreReviewController.requestReview()
        self.view.layer.cornerRadius = 10
    }
    
    
}

