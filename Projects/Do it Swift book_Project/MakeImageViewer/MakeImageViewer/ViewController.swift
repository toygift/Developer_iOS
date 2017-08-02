//
//  ViewController.swift
//  MakeImageViewer
//
//  Created by jaeseong on 2017. 8. 2..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

var numberImage = 0

class ViewController: UIViewController {

    var imageName = ["01.png","02.png","03.png","04.png","05.png","06.png"]
    
    @IBOutlet var imageView:UIImageView!
    
    @IBAction func previous(_ sender:UIButton) {
        
        numberImage -= 1
        
        if numberImage < 0 {
            numberImage = imageName.count-1
        }
        
        imageView.image = UIImage(named: imageName[numberImage])
    }
    
    @IBAction func next(_ sender:UIButton) {
        numberImage += 1
        
        if numberImage >= imageName.count {
            numberImage = 0
        }
        imageView.image = UIImage(named: imageName[numberImage])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageName[0])
    }
}

