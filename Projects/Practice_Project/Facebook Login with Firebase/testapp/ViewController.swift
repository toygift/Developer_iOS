//
//  ViewController.swift
//  testapp
//
//  Created by jaeseong on 2017. 8. 17..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
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
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
        let accessToken = FBSDKAccessToken.current()
      
        guard let accessTokenString = accessToken?.tokenString else { return }
        print("Token",accessTokenString)

        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("something went wrond: ", error ?? "")
                return
            }
            print("successfully log in  user:", user ?? "")
        }
    }



}

