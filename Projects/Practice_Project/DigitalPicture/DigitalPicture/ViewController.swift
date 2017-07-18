//
//  ViewController.swift
//  DigitalPicture
//
//  Created by jaeseong on 2017. 7. 19..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var sliderMove: UISlider!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var clickButton: UIButton!
    
    
    
    @IBAction func toggleButton(_ sender:UIButton) {
        if imageView.isAnimating {
            imageView.stopAnimating()
            clickButton.setTitle("Start", for: .normal)
        } else {
            imageView.animationDuration = Double(sliderMove.value)
            imageView.startAnimating()
            clickButton.setTitle("Stop", for: .normal)
        }
    
    }
    @IBAction func slideSpeen(_ sender:UISlider) {
        imageView.animationDuration = Double(sliderMove.value)
        imageView.startAnimating()
        clickButton.setTitle("Stop", for: .normal)
        self.textLabel.text = "\(sliderMove.value)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "1.jpg")!,
                      UIImage(named: "2.jpg")!,
                      UIImage(named: "3.jpg")!,
                      UIImage(named: "4.jpg")!,
                      UIImage(named: "5.jpg")!,
                      UIImage(named: "6.jpg")!,
                      UIImage(named: "7.jpg")!,
                      UIImage(named: "8.jpg")!,
                      UIImage(named: "9.jpg")!,
                      UIImage(named: "10.jpg")!]
        
        imageView.animationDuration = 15.0
        imageView.animationImages = images
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

