//
//  SignUpPageViewController.swift
//  PickyCookBook
//
//  Created by 유하늘 on 2017. 8. 3..
//  Copyright © 2017년 유하늘. All rights reserved.
//

import UIKit




class SignUpPageViewController: UIViewController {
    
    //var signupUser: User
    
    
    @IBOutlet var emailTextField:UITextField!
    @IBOutlet var nicknameTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    

    @IBAction func signUpButton(_ sender:UIButton) {
        
        
        Data.shared.user?.email = self.emailTextField.text
        Data.shared.user?.nickName = self.nicknameTextField.text
        Data.shared.user?.password = self.passwordTextField.text
        
        //Data.shared.userArray.append()
        
        print(Data.shared.userArray)
    }

}
