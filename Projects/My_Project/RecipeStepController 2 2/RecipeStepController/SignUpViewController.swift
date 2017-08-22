//
//  SignUpViewController.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 20..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class SignUpViewController: UIViewController {
    // MARK: var, let
    //
    var data: JSON = JSON.init(rawValue: [])!
    let firstNameMessage        = "email을 입력하세요"
    let lastNameMessage         = "닉네임을 입력하세요"
    let emailMessage            = "패스워드를 입력하세요"
    let passwordMessage         = "패스워드를 확인합니다"
    
    // MARK: Outlet
    //
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emailInputTextField: DTTextField!
    @IBOutlet var nicknameInputTextField: DTTextField!
    @IBOutlet var passwordTextField: DTTextField!
    @IBOutlet var passwordVerifyTextField: DTTextField!
    @IBOutlet var signupButtons: UIButton!
    @IBOutlet var cancel: UIButton!
    
    @IBAction func cancelsignup(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signupButton(_ sender: UIButton) {
        // guard validateData() else { return }
        guard let email = emailInputTextField.text else { return }
        guard let nickname = nicknameInputTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordConfirm = passwordVerifyTextField.text else { return }
        
        createUserData(email: email, nickname: nickname, password: password, passwordConfirm: passwordConfirm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldBorderColor()
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
        
        self.emailInputTextField.text = ""
        self.nicknameInputTextField.text = ""
        self.passwordTextField.text = ""
        self.passwordVerifyTextField.text = ""
    }
}

// MARK: ALAMOFIRE
//
extension SignUpViewController {
    func createUserData(email: String, nickname: String, password: String, passwordConfirm: String) {
        
        
        let url = "http://pickycookbook.co.kr/api/member/create/"
        let parameters: Parameters = ["email":email, "nickname":nickname, "password1":password, "password2":passwordConfirm]
        let headers : HTTPHeaders = ["Content-Type":"application/json"]
        
        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        call.responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                print("가입성공")
                let json = JSON(value)
                print("JSON: \(json)")
                
                if !(json["email_empty"].stringValue.isEmpty) {
                    Toast(text: "email을 입력해주세요").show()
                } else if !(json["empty_password1"].stringValue.isEmpty) {
                    Toast(text: "password를 입력해주세요").show()
                } else if !(json["empty_password2"].stringValue.isEmpty) {
                    Toast(text: "password확인을 입력해주세요").show()
                } else if !(json["nickname_empty"].stringValue.isEmpty) {
                    Toast(text: "닉네임을 입력해주세요").show()
                } else if !(json["passwords_not_match"].stringValue.isEmpty) {
                    Toast(text: "입력된 패스워드가 일치하지 않습니다").show()
                } else if !(json["email_error"].stringValue.isEmpty) {
                    Toast(text: "다른사용자가 사용중인 이메일입니다").show()
                } else if !(json["nickname_error"].stringValue.isEmpty){
                    Toast(text: "다른사용자가 사용중인 닉네임입니다").show()
                } else if !(json["email_invalid"].stringValue.isEmpty){
                    Toast(text: "유효한이메일입력해주세요").show()
                } else if !(json["empty_passwords"].stringValue.isEmpty){
                    Toast(text: "password를 입력해주세요").show()
                } else if !(json["too_short_password"].stringValue.isEmpty){
                    Toast(text: "password는 최소4자이상 이어야합니다").show()
                } else {
                    guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") else {
                        return
                    }
                    self.present(nextViewController, animated: true, completion: nil)
                    
                }
                
            case .failure(let error):
                print(JSON(error))
                Toast(text: "네트워크에러").show()
            }
        }
    }
    
}

extension SignUpViewController {
    
    func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight.height, 0)
    }
    
    func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    //    func validateData() -> Bool {
    //
    //        guard !emailInputTextField.text!.isEmptyStr else {
    //            emailInputTextField.showError(message: firstNameMessage)
    //            return false
    //        }
    //
    //        guard !nicknameInputTextField.text!.isEmptyStr else {
    //            nicknameInputTextField.showError(message: lastNameMessage)
    //            return false
    //        }
    //
    //        guard !passwordTextField.text!.isEmptyStr else {
    //            passwordTextField.showError(message: emailMessage)
    //            return false
    //        }
    //
    //        guard !passwordVerifyTextField.text!.isEmptyStr else {
    //            passwordVerifyTextField.showError(message: passwordMessage)
    //            return false
    //        }
    //         createUserData(email: emailInputTextField.text!, nickname: nicknameInputTextField.text!, password: passwordTextField.text!, passwordConfirm: passwordVerifyTextField.text!)
    //        return true
    //    }
    
}
extension SignUpViewController {
    func alerts(_ message: String, completion: (()->Void)? = nil) {
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
extension SignUpViewController {
    func textFieldBorderColor(){
        
        emailInputTextField.layer.borderColor = UIColor.black.cgColor
        emailInputTextField.layer.borderWidth = 0.5
        emailInputTextField.layer.cornerRadius = 10
        
        nicknameInputTextField.layer.borderColor = UIColor.black.cgColor
        nicknameInputTextField.layer.borderWidth = 0.5
        nicknameInputTextField.layer.cornerRadius = 10
        
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        
        passwordVerifyTextField.layer.borderColor = UIColor.black.cgColor
        passwordVerifyTextField.layer.borderWidth = 0.5
        passwordVerifyTextField.layer.cornerRadius = 10
        
        signupButtons.layer.borderColor = UIColor.black.cgColor
        signupButtons.layer.borderWidth = 0.5
        signupButtons.layer.cornerRadius = 10
        
        cancel.layer.borderColor = UIColor.red.cgColor
        cancel.layer.borderWidth = 0.5
        cancel.layer.cornerRadius = 10
    }
}
