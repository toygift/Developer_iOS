//
//  ViewController.swift
//  GoogleLogInWithFirebase
//
//  Created by jaeseong on 2017. 8. 18..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogleButton()
        
    }

    fileprivate func setupGoogleButton() {
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

}

