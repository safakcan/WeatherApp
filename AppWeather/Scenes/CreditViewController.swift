//
//  CreditViewController.swift
//  AppWeather
//
//  Created by Can Bas on 12/6/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import UIKit

class CreditViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var htmlView: UIWebView!

    // MARK: LifeCycle

    override func viewDidLoad() {
        checkDeviceLanguageThenLoad()
    }

    // MARK: Configure

    func presentWebView() {
        let url = URL(string: "https://www.adesso.com.tr")
        webView.loadRequest(URLRequest(url: url!))
    }

    func htmlWebViewEnglish() {
        if let path = Bundle.main.path(forResource: "htmlStatic", ofType: "html") {
            htmlView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }

    func htmlWebViewTurkish() {
        if let path = Bundle.main.path(forResource: "htmlStaticTR", ofType: "html") {
            htmlView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }

    func checkDeviceLanguageThenLoad () {
        if Bundle.main.preferredLocalizations.first == "en" {
            htmlWebViewEnglish()
        } else {
            htmlWebViewTurkish()
        }
        presentWebView()
    }

    //: MARK: Actions

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
