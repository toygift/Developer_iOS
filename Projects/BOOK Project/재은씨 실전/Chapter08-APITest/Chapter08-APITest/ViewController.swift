//
//  ViewController.swift
//  Chapter08-APITest
//
//  Created by jaeseong on 2017. 8. 10..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  
    @IBOutlet var userID: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var responseView: UITextView!
    @IBAction func json(_ sender: UIButton) {
        let userId = (self.userID.text)!
        let name = (self.name.text)!
        let param = ["userId":userId, "name":name]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                NSLog("An error has occurred: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    if result == "SUCCESS" {
                        
                        self.responseView.text = "아이디 : \(userId!)" + "\n"
                            + "이름 : \(name!)" + "\n"
                            + "응답결과 : \(result!)" + "\n"
                            + "응답시간 : \(timestamp!)" + "\n"
                            + "요청방식 : x-www-form-urlencoded"
                    }
                } catch let e as NSError {
                    print("에러: \(e.localizedDescription)")
                }
                
            }
        }
        task.resume()
        
    }
    
    @IBAction func post(_ sender: UIButton) {
        let userId = (self.userID.text)!
        let name = (self.name.text)!
        let param = "userId=\(userId)&name=\(name)"
        let paramData = param.data(using: .utf8)
        
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Context-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                NSLog("An error has occurred: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    if result == "SUCCESS" {
                        
                        self.responseView.text = "아이디 : \(userId!)" + "\n"
                        + "이름 : \(name!)" + "\n"
                        + "응답결과 : \(result!)" + "\n"
                        + "응답시간 : \(timestamp!)" + "\n"
                        + "요청방식 : x-www-form-urlencoded"
                    }
                } catch let e as NSError {
                    print("에러: \(e.localizedDescription)")
                }

            }
        }
        task.resume()
    }
    @IBAction func backProfileVC(_ segue: UIStoryboardSegue) {
        
    }
    
}

