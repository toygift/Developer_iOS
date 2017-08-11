//
//  JoinVCViewController.swift
//  Chapter08-APITest
//
//  Created by jaeseong on 2017. 8. 10..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Alamofire

class JoinVCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var isCalling = false
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var profile: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    @IBAction func submit(_ sender: UIButton) {
        if self.isCalling == true {
            self.alert("진행중입니다. 잠시만 기다려주세요")
            return
        } else {
            self.isCalling = true
        }
        self.indicator.startAnimating()
        let profile = UIImagePNGRepresentation(self.profile.image!)?.base64EncodedString()
        let param: Parameters = ["account":self.fieldAccount.text!,
                                 "passwd":self.fieldPassword.text!,
                                 "name":self.fieldName.text!,
                                 "profiel_image":profile!
        ]
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        let call = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        call.responseJSON { (res) in
            self.indicator.stopAnimating()
            guard let jsonObject = res.result.value as? [String:Any] else {
                self.isCalling = false
                self.alert("호출시 오류발생")
                return
            }
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0 {
                self.alert("가입완료") {
                    self.performSegue(withIdentifier: "segue", sender: self)
                    //self.navigationController?.popViewController(animated: true)
                }
                
            } else {
                self.isCalling = false
                let errorMsg = jsonObject["error_msg"] as! String
                self.alert("오류발생: \(errorMsg)")
            }
        }
    }
    
    var fieldAccount: UITextField!
    var fieldPassword: UITextField!
    var fieldName: UITextField!
    
    
    
}

extension JoinVCViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.profile.layer.cornerRadius = self.profile.frame.width / 2
        self.profile.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
        self.view.bringSubview(toFront: self.indicator)
        
        
    }
    @objc func tappedProfile(_ sender: Any) {
        let message = "프로필 이미지를 읽어올 곳을 선택하세요"
        let sheet = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        sheet.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { (_) in
            selectLibrary(src: .savedPhotosAlbum)
        })
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in
            selectLibrary(src: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            selectLibrary(src: .camera)
        })
        self.present(sheet, animated: true, completion: nil)
        
        func selectLibrary(src: UIImagePickerControllerSourceType) {
            if UIImagePickerController.isSourceTypeAvailable(src){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false)
            } else {
                self.alert("사용할수 없는 타입")
            }
        }


        
        
    }
}

extension JoinVCViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width - 20, height: 37)
        
        switch indexPath.row {
        case 0:
            self.fieldAccount = UITextField(frame: tfFrame)
            self.fieldAccount.placeholder = "계정(이메일)"
            self.fieldAccount.borderStyle = .none
            self.fieldAccount.autocapitalizationType = .none
            self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldAccount)
            
        case 1:
            self.fieldPassword = UITextField(frame: tfFrame)
            self.fieldPassword.placeholder = "비밀번호"
            self.fieldPassword.borderStyle = .none
            self.fieldPassword.isSecureTextEntry = true
            self.fieldPassword.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldPassword)
            
        case 2:
            self.fieldName = UITextField(frame: tfFrame)
            self.fieldName.placeholder = "이름"
            self.fieldName.borderStyle = .none
            self.fieldName.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldName)
            
        default:
            ()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension JoinVCViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profile.image = img
        }
        self.dismiss(animated: true)
    }
    
}
extension UIViewController {
    func alert(_ message: String, completion: (()->Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
