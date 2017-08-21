//
//  LoginViewController.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 20..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit
import FBSDKCoreKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    var data: JSON = JSON.init(rawValue: [])!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emilInputTextField: DTTextField!
    @IBOutlet var passwordIntputTextField: DTTextField!
    
    let emailMessage            = "이메일을 입력해주세요"
    let passwordMessage         = "패스워드를 입력해주세요"
   
    
    
    @IBAction func login(_ sender: UIButton){
        guard validateData() else { return }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookSigninButton()
        textFieldBorderColor()
        
    }
    
    func facebookSigninButton(){
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 41, y: 350, width: 300, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email","public_profile"]

    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        
        let accessToken = FBSDKAccessToken.current()
 
        guard let accessTokenString = accessToken?.tokenString else { return }
        print("페이스북토큰:   ",accessTokenString)
        self.faceBookSignin(token: accessTokenString)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func textFieldBorderColor(){
        emilInputTextField.borderColor = .clear
        passwordIntputTextField.borderColor = .clear
    }
}

extension LoginViewController {
    func faceBookSignin(token: String){
        let url = "http://pickycookbook.co.kr/api/member/facebook-login/"
        let parameters: Parameters = ["token":token]
        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        call.responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let currentUserToken = json["token"].stringValue
                // UserDefaults 에 토큰 저장
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "recipeCreate") else {
                    return
                }
                self.present(nextViewController, animated: true, completion: nil)
                
            case .failure(let error):
                self.alert("실패")
                print(error)
            }
        }
    }
    
    func loginUserData(email: String, password: String) {
        
        let url = "http://pickycookbook.co.kr/api/member/login/"
        let parameters: Parameters = ["email":email, "password":password]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        call.validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)

                // UserDefaults 에 토큰 저장
                let currentUserToken = json["token"].stringValue
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                
                
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "recipeCreate") else {
                    return
                }
                self.present(nextViewController, animated: true, completion: nil)
                
                
            case .failure(let error):
                
                self.alert("이메일 또는 비밀번호를 확인하세요")
                print(error)
                
            }
        }
    }
}


extension LoginViewController {
    
    func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight.height, 0)
    }
    
    func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        
        guard !emilInputTextField.text!.isEmptyStr else {
            emilInputTextField.showError(message: emailMessage)
            return false
        }
        
        guard !passwordIntputTextField.text!.isEmptyStr else {
            passwordIntputTextField.showError(message: passwordMessage)
            return false
        }
        loginUserData(email: emilInputTextField.text!, password: passwordIntputTextField.text!)
        
        
        return true
    }

}
extension LoginViewController {
    func alert(_ message: String, completion: (()->Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
                completion?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

