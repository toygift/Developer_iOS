//
//  DetailViewController.swift
//  MemoAlone_custom
//
//  Created by jaeseong Lee on 2017. 7. 11..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//
/* 
// 1. UserDefault  사용해보기
// 2. 추가할것..초기화 되는 문제 해결하기
//
//
//
//
 */

import UIKit

class DetailViewController: UIViewController {
    
   
    var contactArray: [[String:String]] = []
    
    @IBOutlet weak private var nameInputText: UITextField!
    @IBOutlet weak private var phoneNumber: UITextField!
    @IBOutlet weak private var whereAreYou: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    @IBAction  func saveContact(_ sender: UIButton) {
        addArray()
        self.navigationController?.popViewController(animated: true)
    }
    
    //함수 생성...배열에 저장하는 함수
    func addArray() {
        let name = nameInputText.text
        let phone = phoneNumber.text
        let live = whereAreYou.text
        
        let contact: [String:String] = ["name": name!, "phone": phone!, "live": live!]
        
        DataCentre.shared.dataArray.append(contact)
        
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
