//
//  MyInfoModify.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 21..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster


class MyInfoModify: UIViewController {
    
    var data: JSON = JSON.init(rawValue: [])!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var newpasswordTextField: UITextField!
    @IBOutlet var newpasswordVerifyTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserData()
    }
    
    @IBAction func completeVerify(_ sender: UIButton) {
      
        patchUserData(nickname: nicknameTextField.text!, password: passwordTextField.text!, newpassword: newpasswordTextField.text!, newpasswordVerify: newpasswordVerifyTextField.text!, content: contentTextField.text!)

    }
    
    
}

extension MyInfoModify {
    func patchUserData(nickname: String, password: String, newpassword: String, newpasswordVerify: String, content: String){
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let userPK = UserDefaults.standard.object(forKey: "userPK") as! Int
        print("유저pk             : ",userPK)
        let url = "http://pickycookbook.co.kr/api/member/update/\(userPK)/"
        let parameters: Parameters = ["nickname":nickname, "password":password, "password1":newpassword, "password2":newpasswordVerify, "content":content]
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        let call = Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        call.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let result = JSON(value)
                print(result)
                
                if !(result["nickname"].arrayValue.isEmpty) {
                    Toast(text: "이미사용중아이디").show()
                } else if !(result["old_password_error"].stringValue.isEmpty) {
                    Toast(text: "기존패스워드오류").show()
                } else if !(result["passwords_not_match"].stringValue.isEmpty) {
                    Toast(text: "패스워드 확인 오류").show()
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error)
                Toast(text: "입력해주세요").show()
                
            }
        }
    }
}

extension MyInfoModify {
    func fetchUserData(){
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let userPK = UserDefaults.standard.object(forKey: "userPK") as! Int
        let url = "http://pickycookbook.co.kr/api/member/detail/\(userPK)/"
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let result = JSON(value)
                print(result)
                self.nickNameLabel.text = result["nickname"].stringValue
                self.contentLabel.text = result["content"].stringValue
                let password = result["password"].stringValue
                UserDefaults.standard.set(password, forKey: "password")
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
