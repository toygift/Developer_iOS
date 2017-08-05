//
//  AddViewController.swift
//  TableView
//
//  Created by jaeseong on 2017. 8. 5..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var tfAddItem: UITextField!
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append("clock.png")
        tfAddItem.text = ""
        _ = navigationController?.popViewController(animated: true)
    }
}
