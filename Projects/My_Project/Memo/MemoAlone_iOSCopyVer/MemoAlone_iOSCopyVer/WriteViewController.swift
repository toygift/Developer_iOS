//
//  WriteViewController.swift
//  MemoAlone_iOSCopyVer
//
//  Created by jaeseong Lee on 2017. 7. 11..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var memoTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        if let inputMemo = memoTextField.text {
            DataCentre.shared.mainMemoArray.append(inputMemo)
        }

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
