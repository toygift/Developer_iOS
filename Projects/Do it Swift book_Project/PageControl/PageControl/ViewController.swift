//
//  ViewController.swift
//  PageControl
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

var images = ["01.png","02.png","03.png","04.png","05.png","06.png"]

class ViewController: UIViewController {

    @IBOutlet var imageView:UIImageView!
    @IBOutlet var pageControl:UIPageControl!
    
    @IBAction func pageChanged(_ sender:UIPageControl) {
        imageView.image = UIImage(named: images[pageControl.currentPage])
    }

}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = images.count
        
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.green
        
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        imageView.image = UIImage(named: images[0])
    }
}
