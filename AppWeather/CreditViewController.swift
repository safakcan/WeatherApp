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
    @IBOutlet weak var htmlView: UIWebView!
    
    
    override func viewDidLoad() {
        presentWebView()
        htmlWebView()
    }
    
    func presentWebView() {
        let url = URL(string: "https://www.adesso.com.tr")
        webView.loadRequest(URLRequest(url: url!))
        
    }
    
    func htmlWebView() {
        
        if let path = Bundle.main.path(forResource: "htmlStatic", ofType: "html") {
            htmlView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)) )
        }
    }
}
