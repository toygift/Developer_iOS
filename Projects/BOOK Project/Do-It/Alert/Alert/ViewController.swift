//
//  ViewController.swift
//  Alert
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imgOn: UIImage = UIImage(named: "lamp-on.png")!
    let imgOff: UIImage = UIImage(named: "lamp-off.png")!
    let imgDelete:UIImage = UIImage(named: "lamp-remove.png")!
 
    var isLampOn = true
    
    @IBOutlet var imageView:UIImageView!
    
    
}

extension ViewController {
    override func viewDidLoad() {
        imageView.image = imgOn
    }
}

extension ViewController {
    
    @IBAction func onSwitch(_ sender:UIButton) {
        if isLampOn == true {
            let lampOnAlert = UIAlertController(title: "경고", message: "현재on상태", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "네,알겠습니다", style: .default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
            
        } else {
            imageView.image = imgOn
            isLampOn = true
        }
        
    }
    
    @IBAction func offSwitch(_ sender:UIButton) {
        if isLampOn {
            let lampOffAlert = UIAlertController(title: "램프끄기", message: "램프를끄시겠습니까?", preferredStyle: .alert)
            let offAction = UIAlertAction(title: "네", style: .default, handler: { (ACTION) in
                self.imageView.image = self.imgOff
                self.isLampOn = false
            })
            let cancelAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func deleteSwitch(_ sender:UIButton) {
        let lampDeleteAlert = UIAlertController(title: "램프제거", message: "램프를제거하시겠습니까?", preferredStyle: .alert)
        let onAction = UIAlertAction(title: "아니오, 켭니다(on)", style: .default) { (ACTION) in
            self.imageView.image = self.imgOn
            self.isLampOn = true
        }
        let offAction = UIAlertAction(title: "아니오, 끕니다(off)", style: .default) { (ACTION) in
            self.imageView.image = self.imgOff
            self.isLampOn = false
        }
        let deleteAction = UIAlertAction(title: "네. 제거합니다?", style: .destructive) { (ACTION) in
            self.imageView.image = self.imgDelete
            self.isLampOn = false
        }
        
        lampDeleteAlert.addAction(onAction)
        lampDeleteAlert.addAction(offAction)
        lampDeleteAlert.addAction(deleteAction)
        
        present(lampDeleteAlert, animated: true, completion: nil)
        
    }
}
