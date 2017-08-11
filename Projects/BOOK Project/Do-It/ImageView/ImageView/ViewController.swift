//
//  ViewController.swift
//  ImageView
//
//  Created by jaeseong on 2017. 8. 2..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    

    @IBOutlet var imageView:UIImageView!
    @IBOutlet var buttonResize:UIButton!
    
    @IBAction func buttonResizeImage(_ sender:UIButton) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat
        var newHeight: CGFloat
        
        if (isZoom) {
            newWidth = imageView.frame.width/scale
            newHeight = imageView.frame.height/scale
            imageView.frame.size = CGSize(width: newWidth, height: newHeight)
            buttonResize.setTitle("확대", for: .normal)
        } else {
            newWidth = imageView.frame.width*scale
            newHeight = imageView.frame.height*scale
            imageView.frame.size = CGSize(width: newWidth, height: newHeight)
            buttonResize.setTitle("축소", for: .normal)
        }
        isZoom = !isZoom
        
        
    }
    @IBAction func switchImageOnOff(_ sender:UISwitch) {
        if sender.isOn {
            imageView.image = imgOn
        } else {
            imageView.image = imgOff
        }
        
    }

    override func viewDidLoad() {
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imageView.image = imgOn
    }
}

