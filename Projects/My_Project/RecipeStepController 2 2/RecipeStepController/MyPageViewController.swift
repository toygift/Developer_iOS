//
//  MyPageViewController.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 21..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster


class MyPageViewController: UIViewController {
    
    
    @IBOutlet var myinfoedit: UIButton!
    @IBOutlet var bookmarklist: UIButton!
    @IBOutlet var mybookmakrlist : UIButton!
    @IBOutlet var myrecipecreate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borders()
        
    }
 
}

// MARK: Border setting
//
extension MyPageViewController{
    func borders(){
        myinfoedit.layer.borderColor = UIColor.black.cgColor
        myinfoedit.layer.borderWidth = 0.5
        myinfoedit.layer.cornerRadius = 10
        
        bookmarklist.layer.borderColor = UIColor.black.cgColor
        bookmarklist.layer.borderWidth = 0.5
        bookmarklist.layer.cornerRadius = 10
        
        mybookmakrlist.layer.borderColor = UIColor.black.cgColor
        mybookmakrlist.layer.borderWidth = 0.5
        mybookmakrlist.layer.cornerRadius = 10
        
        myrecipecreate.layer.borderColor = UIColor.black.cgColor
        myrecipecreate.layer.borderWidth = 0.5
        myrecipecreate.layer.cornerRadius = 10
    }
}
