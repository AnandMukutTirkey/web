//
//  ViewController.swift
//  web
//
//  Created by anand mukut tirkey on 12/01/18.
//  Copyright © 2018 anand mukut tirkey. All rights reserved.
//

import Cocoa
import AppKit
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myWebView.layer?.cornerRadius = 10
        self.inputField.becomeFirstResponder()

    }
    
    override func viewWillAppear() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        view.window?.level = .floating
        
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        
        let url : URL = URL(string: "https://www.apple.com")!
        let urlRequest = URLRequest(url: url)
        myWebView.load(urlRequest)
        //print("loaded url")
    }
    
    
    @IBAction func searchGoogle(_ sender: NSTextField) {
        if sender.stringValue.hasPrefix("http"){
            if let url = URL(string: sender.stringValue){
                let request = URLRequest(url: url)
                myWebView.load(request)
            }else{
                showAlert(message: "wrong url")
            }
        }else{
            var string = "http://www.google.com/search?q=\(sender.stringValue)"
            string = string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
            if let url = URL(string: string){
                //print("loading website")
                let request = URLRequest(url: url)
                myWebView.load(request)
            }else{
                showAlert(message: "oops ! wrong url, contact developer for fix")
            }
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func showAlert(message: String) {
        let alert = NSAlert()
        alert.messageText = "alert"
        alert.informativeText = message//"the url you are trying to load is not in proper format. it may include white sapce etc. 😨"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.beginSheetModal(for: NSApplication.shared.keyWindow!, completionHandler: nil)
    }
}


extension ViewController : WKUIDelegate, WKNavigationDelegate{
    
    //trying to catch errors here
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showAlert(message: error.localizedDescription)
    }
    
    override func webPlugInMainResourceDidFailWithError(_ error: Error!) {
        print(error)
    }
}

