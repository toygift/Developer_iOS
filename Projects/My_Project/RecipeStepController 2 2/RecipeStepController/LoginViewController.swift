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
import Toaster

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: var, let
    var data: JSON = JSON.init(rawValue: [])!
    let emailMessage            = "이메일을 입력해주세요"
    let passwordMessage         = "패스워드를 입력해주세요"
    
    // MARK: Outlet
    //
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emilInputTextField: DTTextField!
    @IBOutlet var passwordIntputTextField: DTTextField!
    @IBOutlet var loginB: UIButton!
    @IBOutlet var signupB: UIButton!
    
    @IBAction func login(_ sender: UIButton){
        guard let email = emilInputTextField.text else { return }
        guard let password = passwordIntputTextField.text else { return }
        
        loginUserData(email: email, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookSigninButton()
        textFieldBorderColor()
        
    }
    // MARK: Facebook LoginButton
    func facebookSigninButton(){
        
        let loginButton = FBSDKLoginButton()
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.cornerRadius = 10
        loginButton.frame = CGRect(x: 41, y: 350, width: 300, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email","public_profile"]
        
        
        view.addSubview(loginButton)
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out facebook")
    }
    
    // MARK: Facebook login get Token
    //
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
        
        self.emilInputTextField.text = ""
        self.passwordIntputTextField.text = ""
    }
}
// MARK: Facebook Login
//
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
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                let currentUserPk = json["pk"].intValue
                UserDefaults.standard.set(currentUserPk, forKey: "userPK")
                // UserDefaults 에 토큰 저장
                
                
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") else {
                    return
                }
                self.present(nextViewController, animated: true, completion: nil)
                
            case .failure(let error):
                Toast(text: "네트워크에러").show()
                print(error)
            }
        }
    }
    // MARK: Email Login
    //
    func loginUserData(email: String, password: String) {
        
        let url = "http://pickycookbook.co.kr/api/member/login/"
        let parameters: Parameters = ["email":email, "password":password]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        call.responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                if !(json["email_empty"].stringValue.isEmpty) {
                    Toast(text: "email을 입력해주세요").show()
                } else if !(json["empty_password1"].stringValue.isEmpty) {
                    Toast(text: "password를 입력해주세요").show()
                } else if !(json["empty_error"].stringValue.isEmpty) {
                    Toast(text: "email과 password를 입력해주세요").show()
                } else if !(json["login_error"].stringValue.isEmpty) {
                    Toast(text: "email 또는 비밀번호가 맞지 않습니다").show()
                } else {
                    // UserDefaults 에 토큰 저장
                    let currentUserToken = json["token"].stringValue
                    UserDefaults.standard.set(currentUserToken, forKey: "token")
                    let currentUserPk = json["pk"].intValue
                    UserDefaults.standard.set(currentUserPk, forKey: "userPK")
                    
                    guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") else {
                        return
                    }
                    self.present(nextViewController, animated: true, completion: nil)
                }
                
                
                
            case .failure(let error):
                Toast(text: "네트워크에러").show()
                print(error)
                
            }
        }
    }
}

// MARK: 키보드
//
extension LoginViewController {
    
    func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight.height, 0)
    }
    
    func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    //    func validateData() -> Bool {
    //
    //        guard !emilInputTextField.text!.isEmptyStr else {
    //            emilInputTextField.showError(message: emailMessage)
    //            return false
    //        }
    //
    //        guard !passwordIntputTextField.text!.isEmptyStr else {
    //            passwordIntputTextField.showError(message: passwordMessage)
    //            return false
    //        }
    //        loginUserData(email: emilInputTextField.text!, password: passwordIntputTextField.text!)
    //
    //
    //        return true
    //    }
    
}
// MARK: Alert custom
//
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
// MARK: Border setting
//
extension LoginViewController {
    func textFieldBorderColor(){
        
        emilInputTextField.layer.borderColor = UIColor.black.cgColor
        emilInputTextField.layer.borderWidth = 0.1
        emilInputTextField.layer.cornerRadius = 10
        
        passwordIntputTextField.layer.borderColor = UIColor.black.cgColor
        passwordIntputTextField.layer.borderWidth = 0.1
        passwordIntputTextField.layer.cornerRadius = 10
        
        loginB.layer.borderColor = UIColor.clear.cgColor
        loginB.layer.borderWidth = 0.5
        loginB.layer.cornerRadius = 10
//        loginB.layer.backgroundColor = UIColor.aqua.cgColor
        loginB.setTitleColor(UIColor.white, for: .normal)
        
        
        signupB.layer.borderColor = UIColor.clear.cgColor
        signupB.layer.borderWidth = 0.5
        signupB.layer.cornerRadius = 10
        signupB.setTitleColor(UIColor.white, for: .normal)
    }
    
}
