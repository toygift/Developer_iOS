//
//  MainViewController.swift
//  MemoAlone_DataCentre
//
//  Created by jaeseong Lee on 2017. 7. 11..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var inputMemoField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        inputMemoField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        inputMemoField.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMemoButton(_ sender: UIButton) {
        let memo = inputMemoField.text!
        DataCentre.shared.memoArray.append(memo)
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
