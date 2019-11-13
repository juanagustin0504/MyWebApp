//
//  ViewController.swift
//  MyWebApp
//
//  Created by Webcash on 2019/11/13.
//  Copyright © 2019 Moon. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://bizplay.co.kr")
        let request = URLRequest(url: url!)	
        webView.load(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in completionHandler(true)
            
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: {
            (action) in completionHandler(false)
            
        }))
        self.present(alertController, animated: true, completion: nil) }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        alertController.addTextField {
            (textField) in textField.text = defaultText
            
        }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in
            if let text = alertController.textFields?.first?.text { completionHandler(text)
                
            } else {
                completionHandler(defaultText)
                
            }
            
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: {
            (action) in completionHandler(nil)
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            
        };
        
        return nil
        
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) { webView.reload() }


}

