//
//  DetailViewController.swift
//  TableView
//
//  Created by jaeseong on 2017. 8. 5..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {

    var receiveItem = ""
    
    @IBOutlet var labelItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelItem.text = receiveItem
    }
 
    func receiveItem(_ item: String) {
        receiveItem = item
    }
}
