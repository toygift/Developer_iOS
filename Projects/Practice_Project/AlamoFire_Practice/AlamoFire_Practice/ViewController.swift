//
//  ViewController.swift
//  AlamoFire_Practice
//
//  Created by jaeseong on 2017. 7. 20..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data: JSON = JSON.init(rawValue: [])!

    @IBOutlet var tableview: UITableView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    @IBAction func fetchUserData(_ sender: UIButton) {
        self.fetchUserData()
    }
    
    @IBAction func createUserData(_ sender: UIButton) {
        self.createUserData(email: emailTextField.text!, password: passwordTextField.text!)
    
    }
    
    func refreshData() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /****************tableview****************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let email = self.data[indexPath.row]["email"].stringValue
        let password = self.data[indexPath.row]["password"].stringValue
        
        cell.textLabel?.text = email
        cell.detailTextLabel?.text = password
        return cell
    }

    func fetchUserData() {
        Alamofire.request("http://localhost:1337/user").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.data = JSON(value)
                self.refreshData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func createUserData(email: String, password: String) {
        
        let params = ["email": email, "password": password]
        
        Alamofire.request("http://localhost:1337/user", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                self.refreshData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

