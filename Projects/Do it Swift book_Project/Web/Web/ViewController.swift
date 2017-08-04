//
//  ViewController.swift
//  Web
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtUrl:UITextField!
    @IBOutlet var myWebView:UIWebView!
    @IBOutlet var myActivityIndicator:UIActivityIndicatorView!


}

extension ViewController {
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.loadRequest(myRequest)
    }
    
    func checkUrl(_ url: String) -> String {
        
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
}



extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        loadWebPage("http://2sam.net")
        
    }
}

extension ViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivityIndicator.stopAnimating()
    }
}

extension ViewController {
    @IBAction func goButton(_ sender:UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
        
    }
    
    @IBAction func siteOne(_ sender:UIButton) {
        loadWebPage("http://toygift7.tistory.com")
    }
    
    @IBAction func siteTwo(_ sender:UIButton) {
        loadWebPage("http://toygift.github.io")
    }
    
    @IBAction func html(_ sender:UIButton) {
        let htmlString = "<h1>HTML String</h1><p>String변수를 이용한 웹페이지</p><p><a href=\"http://toygift7.tistory.com\">toygift</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func file(_ sender:UIButton) {
        let myHtmlBundle = Bundle.main
        let filePath = myHtmlBundle.path(forResource: "htmlView", ofType: "html")
        loadWebPage(filePath!)
    }
}

extension ViewController {
    @IBAction func stop(_ sender:UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    @IBAction func refresh(_ sender:UIBarButtonItem) {
        myWebView.reload()
    }
    
    @IBAction func rewind(_ sender:UIBarButtonItem) {
        myWebView.goBack()
    }
    
    @IBAction func fastrewind(_ sender:UIBarButtonItem) {
        myWebView.goForward()
    }
}

