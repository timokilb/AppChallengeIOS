//
//  WebViewController.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 11.07.22.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var url: URL?
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else { return }
        webView.load(myRequest)
    }}
