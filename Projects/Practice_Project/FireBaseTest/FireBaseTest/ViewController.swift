//
//  ViewController.swift
//  FireBaseTest
//
//  Created by jaeseong on 2017. 7. 15..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    //Firebase
    var refer: DatabaseReference!
    
    //Outlet 
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputValue: UITextField!
    @IBOutlet weak var inputKey: UITextField!
    
    @IBOutlet weak var deleteValue: UITextField!
    @IBOutlet weak var selectName: UITextField!
    @IBOutlet weak var selectValue: UITextField!
    
    @IBAction func clickInsert(_ sender: UIButton) {
        
        let itemRef = refer.child(((inputName).text?.lowercased())!).child((inputKey.text?.lowercased())!)
        itemRef.setValue(inputValue.text!)
        
        self.inputName.text = ""
        self.inputValue.text = ""
        
    }
    
    
    @IBAction func clickDelete(_ sender: UIButton) {
        let itemRef = refer.child((deleteValue.text?.lowercased())!)
        itemRef.removeValue { (error, ref) in
            if error != nil {
                print("!!")
            }
            self.deleteValue.text = ""
        }
    }
    
    
    @IBAction func clickSelect(_ sender: UIButton) {
        let itemRef = refer.child((selectName.text?.lowercased())!)
        itemRef.observeSingleEvent(of: .value, with: { (DataSnapShot) in
            let rValue = DataSnapShot.value as? String
        
            self.selectValue.text = rValue
            self.selectName.text = ""
            //dictionary    형태로 가지고 와서

        })
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Firebase
        refer = Database.database().reference()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

