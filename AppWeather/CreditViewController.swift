//
//  CreditViewController.swift
//  AppWeather
//
//  Created by Can Bas on 12/6/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class CreditViewController: UIViewController  {
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        presentWebView()
    }
    
    func presentWebView() {
        let url = URL(string: "https://www.adesso.com.tr")
        webView.loadRequest(URLRequest(url: url!))
        
    }
    
}
