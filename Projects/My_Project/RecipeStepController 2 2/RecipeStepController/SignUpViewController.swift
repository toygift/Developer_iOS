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

class SignUpViewController: UIViewController {
    var data: JSON = JSON.init(rawValue: [])!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emailInputTextField: DTTextField!
    @IBOutlet var nicknameInputTextField: DTTextField!
    @IBOutlet var passwordTextField: DTTextField!
    @IBOutlet var passwordVerifyTextField: DTTextField!

    @IBAction func signupButton(_ sender: UIButton) {
        guard validateData() else { return }
       
    }
    
    
    let firstNameMessage        = "email을 입력하세요"
    let lastNameMessage         = "닉네임을 입력하세요"
    let emailMessage            = "패스워드를 입력하세요"
    let passwordMessage         = "패스워드를 확인합니다"
    
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
    }

    func textFieldBorderColor(){
        emailInputTextField.borderColor = .clear
        nicknameInputTextField.borderColor = .clear
        passwordTextField.borderColor = .clear
        passwordVerifyTextField.borderColor = .clear
    }
}
extension SignUpViewController {
    func createUserData(email: String, nickname: String, password: String, passwordConfirm: String) {
        
        
        let url = "http://pickycookbook.co.kr/api/member/create/"
        let parameters: Parameters = ["email":email, "nickname":nickname, "password1":password, "password2":password]
        let headers : HTTPHeaders = ["Content-Type":"application/json"]
        
        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        call.validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                print("가입성공")
                let json = JSON(value)
                print("JSON: \(json)")
                
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "recipeCreate") else {
                    return
                }
                self.present(nextViewController, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                self.alerts("이메일 및 닉네임중복")
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
    
    func validateData() -> Bool {
        
        guard !emailInputTextField.text!.isEmptyStr else {
            emailInputTextField.showError(message: firstNameMessage)
            return false
        }
        
        guard !nicknameInputTextField.text!.isEmptyStr else {
            nicknameInputTextField.showError(message: lastNameMessage)
            return false
        }
        
        guard !passwordTextField.text!.isEmptyStr else {
            passwordTextField.showError(message: emailMessage)
            return false
        }
        
        guard !passwordVerifyTextField.text!.isEmptyStr else {
            passwordVerifyTextField.showError(message: passwordMessage)
            return false
        }
         createUserData(email: emailInputTextField.text!, nickname: nicknameInputTextField.text!, password: passwordTextField.text!, passwordConfirm: passwordVerifyTextField.text!)
        return true
    }
    
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

