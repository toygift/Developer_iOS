//
//  MemoController.swift
//  MemoAlone
//
//  Created by jaeseong Lee on 2017. 7. 10..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//
/*********************************************메모*********************************************/
// 1차시도 테이터만 넘김, 추가 UITextFieldDelegate 추가해서 endEditing
// 2차시도 UserDefaults
//
/*********************************************메모*********************************************/
import UIKit

class MemoController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var memoInputTextField: UITextField!
    
    var memoSendArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        memoInputTextField.placeholder = "메모입력하세요"
        
        let memotext = memoInputTextField.text
        memoSendArray.append(memotext!)
        memoInputTextField.becomeFirstResponder()
        //memoInputTextField.clearsOnBeginEditing = true
        
        print(memoSendArray)
        
        guard let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as? MemoTableController else {
            return
        }
        
        detail.memoReceiveAarray = memoSendArray
        
        self.navigationController?.pushViewController(detail, animated: true)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //memoInputTextField.clearsOnBeginEditing = true
        //왜 여기선 클리어가 안되지..? Did가 아닌가.?
        //아닌거 같음 -> 왜냐하면 ok버튼 누름과 동시에 화면이 넘어갈거 같은데?
        //그럼 넘어갔다가 돌아올때 없애야 된단소린데..그럼 여기가 아니라
        //viewWillApper에다 실험해보자
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoInputTextField.clearsOnBeginEditing = true
        //여기다가 해도 되는군..
        //넘어갈때 혹은 넘어갔다가 되돌아 올때..둘다 확인!
        //textFieldDelegate는 그럼 언제쓰지?
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
