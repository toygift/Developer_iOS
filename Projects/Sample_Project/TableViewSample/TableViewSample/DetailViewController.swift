//
//  DetailViewController.swift
//  TableViewSample
//
//  Created by youngmin joo on 2017. 6. 2..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var img:UIImageView!
    @IBOutlet var titleLb:UILabel!
    
    
    var imgName:String?
    var titleName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imgName = self.imgName ?? "DefaultImageName"
        let poketName = self.titleName ?? "이름 모름"
        
        img.image = UIImage(named: imgName)
        titleLb.text = poketName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
