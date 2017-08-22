//
//  MyInfoModify.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 21..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster
import AssetsLibrary
import MobileCoreServices

class MyInfoModify: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: var, let
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false
    var captureImage: UIImage!
    var videoURL: URL!
    var data: JSON = JSON.init(rawValue: [])!
    
    // MARK: Outlet
    //
    @IBOutlet var profile_image: UIImageView!
    
    @IBOutlet var oldpasswd: UILabel!
    @IBOutlet var passnew: UILabel!
    @IBOutlet var passnewVe: UILabel!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var withdrawalButton: UIButton!
    @IBOutlet var pictureSelect: UIButton!
    
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var newpasswordTextField: UITextField!
    @IBOutlet var newpasswordVerifyTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        border()
        fetchUserData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.nicknameTextField.text = ""
        self.passwordTextField.text = ""
        self.newpasswordTextField.text = ""
        self.newpasswordVerifyTextField.text = ""
        self.contentTextField.text = ""
    }
    // MARK: 수정취소
    @IBAction func exit(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: 로그아웃
    //
    @IBAction func logout(_ sender: UIButton){
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let url = "http://pickycookbook.co.kr/api/member/logout/"
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    // MARK: 회원탈퇴
    //
    @IBAction func withdrawal(_ sender: UIButton){
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let userPK = UserDefaults.standard.object(forKey: "userPK") as! Int
        print("유저pk             : ",userPK)
        let url = "http://pickycookbook.co.kr/api/member/update/\(userPK)/"
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: 사진선택
    //
    @IBAction func pictureSelect(_ sender: UIButton){
        let alert = UIAlertController(title: "선택", message: "선택해주세요", preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "포토라이브러리", style: .default) { (_) in
            self.media(.photoLibrary, flag: false, editing: true)
        }
        let carema = UIAlertAction(title: "카메라", style: .default) { (_) in
            self.media(.camera, flag: true, editing: false)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(photo)
        alert.addAction(carema)
        
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: 수정완료
    //
    @IBAction func completeVerify(_ sender: UIButton) {
        //        guard !nicknameTextField.text!.isEmptyStr else {
        //            Toast(text: "닉네임을 입력하세요").show()
        //            return
        //        }
        //        guard !contentTextField.text!.isEmptyStr else {
        //            Toast(text: "content를 입력하세요").show()
        //            return
        //        }
        
        guard let nickname = nicknameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let newpassword = newpasswordTextField.text else { return }
        guard let newpasswordVerify = newpasswordVerifyTextField.text else { return }
        guard let content = contentTextField.text else { return }
        
        patchUserData(nickname: nickname, password: password, newpassword: newpassword, newpasswordVerify: newpasswordVerify, content: content)
        
    }
    
    
}
// MARK: 수정(Alamo)
extension MyInfoModify {
    func patchUserData(nickname: String, password: String, newpassword: String, newpasswordVerify: String, content: String){
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let userPK = UserDefaults.standard.object(forKey: "userPK") as! Int
        print("유저pk             : ",userPK)
        let url = "http://pickycookbook.co.kr/api/member/update/\(userPK)/"
        let parameters: Parameters = ["nickname":nickname, "password":password, "password1":newpassword, "password2":newpasswordVerify, "content":content, "img_profile":captureImage]
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        ////////////////////////////////////////////////////////////////////
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            for (key, value) in parameters {
                
                if key == "nickname" || key == "password" || key == "password1" || key == "password2" || key == "content" {
                    
                    multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
                } else if let photo = self.captureImage, let imgData = UIImageJPEGRepresentation(photo, 0.25) {
                    multipartFormData.append(imgData, withName: "img_profile", fileName: "photo.jpg", mimeType: "image/jpg")
                }
                
            }//for
            
        }, to: url, method: .patch, headers: headers)
        { (response) in
            switch response {
            case .success(let upload, _, _):
                print("업로드드드드드", upload)
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        let result = JSON(value)
                        
                        if !(result["nickname_exists"].stringValue.isEmpty) {
                            Toast(text: "이미사용중인 닉네임").show()
                        } else if !(result["old_password_error"].stringValue.isEmpty) {
                            Toast(text: "기존패스워드오류").show()
                        } else if !(result["passwords_not_match"].stringValue.isEmpty) {
                            Toast(text: "패스워드 확인 오류").show()
                        } else if !(result["empty_old_password"].stringValue.isEmpty) {
                            Toast(text: "기존패스워드를 확인해주세요").show()
                        } else if !(result["empty_password1"].stringValue.isEmpty){
                            Toast(text: "첫번째패스워드를 입력해주세요").show()
                        } else if !(result["empty_password2"].stringValue.isEmpty) {
                            Toast(text: "패스워드확인을 입력해주세요").show()
                        } else if !(result["too_short_password"].stringValue.isEmpty){
                            Toast(text: "패스워드는 최소4자이상입니다").show()
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                    print("리스폰스스스스스: ",response)
                    
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
        ////////////////////////////////////////////////////////////////////
        
        //        let call = Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        //        call.responseJSON { (response) in
        //            switch response.result {
        //            case .success(let value):
        //                let result = JSON(value)
        //                print(result)
        //
        //                if !(result["nickname_exists"].stringValue.isEmpty) {
        //                    Toast(text: "이미사용중아이디").show()
        //                } else if !(result["old_password_error"].stringValue.isEmpty) {
        //                    Toast(text: "기존패스워드오류").show()
        //                } else if !(result["passwords_not_match"].stringValue.isEmpty) {
        //                    Toast(text: "패스워드 확인 오류").show()
        //                } else if !(result["empty_password1"].stringValue.isEmpty){
        //                    Toast(text: "첫번째패스워드를 입력해주세요").show()
        //                } else if !(result["empty_password2"].stringValue.isEmpty) {
        //                    Toast(text: "패스워드확인을 입력해주세요").show()
        //                } else if !(result["too_short_password"].stringValue.isEmpty){
        //                    Toast(text: "패스워드는 최소4자이상입니다").show()
        //                } else {
        //                    self.dismiss(animated: true, completion: nil)
        //                }
        //
        //            case .failure(let error):
        //                print(error)
        //                Toast(text: "입력해주세요").show()
        //
        //            }
        //        }
    }
}
// MARK: 불러오기(Alamo)
//
extension MyInfoModify {
    func fetchUserData(){
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let userPK = UserDefaults.standard.object(forKey: "userPK") as! Int
        let url = "http://pickycookbook.co.kr/api/member/detail/\(userPK)/"
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let result = JSON(value)
                print(result)
                self.nickNameLabel.text = result["nickname"].stringValue
                self.contentLabel.text = result["content"].stringValue
                ////////////////////////////////////////////////////////
                if let path = result["img_profile"].string {
                    if let imageData = try? Data(contentsOf: URL(string: path)!) {
                        self.profile_image.image = UIImage(data: imageData)
                    }
                }
                
                ////////////////////////////////////////////////////////
                
                let password = result["password"].stringValue
                UserDefaults.standard.set(password, forKey: "password")
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}




// MARK: 포토라이브러리, 카메라
//
extension MyInfoModify {
    func media(_ type: UIImagePickerControllerSourceType, flag: Bool, editing: Bool){
        if (UIImagePickerController.isSourceTypeAvailable(type)) {
            flagImageSave = flag
            
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = editing
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            if type == .photoLibrary{
                Toast(text: "포토라이브러리에 접근할수 없음").show()
            } else {
                Toast(text: "카메라에 접근할수 없음").show()
            }
        }
    }
    
    // MARK: 사진, 비디오, 포토라이브러리 선택 끝났을때
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            //capture image(이미지 저장된것 처리)
        }
            // 비디오 처리(사용하진 않음)
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            if flagImageSave {
                videoURL = (info[UIImagePickerControllerMediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: 사진, 비디오 취소시
    //
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: Border setting
//
extension MyInfoModify {
    func border(){
        
        oldpasswd.layer.borderColor = UIColor.black.cgColor
        oldpasswd.layer.borderWidth = 0.5
        oldpasswd.layer.cornerRadius = 10
        
        passnew.layer.borderColor = UIColor.black.cgColor
        passnew.layer.borderWidth = 0.5
        passnew.layer.cornerRadius = 10
        
        passnewVe.layer.borderColor = UIColor.black.cgColor
        passnewVe.layer.borderWidth = 0.5
        passnewVe.layer.cornerRadius = 10
        
        nickNameLabel.layer.borderColor = UIColor.black.cgColor
        nickNameLabel.layer.borderWidth = 0.5
        nickNameLabel.layer.cornerRadius = 10
        
        contentLabel.layer.borderColor = UIColor.black.cgColor
        contentLabel.layer.borderWidth = 0.5
        contentLabel.layer.cornerRadius = 10
        
        
        cancelButton.layer.borderColor = UIColor.blue.cgColor
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.cornerRadius = 10
        
        okButton.layer.borderColor = UIColor.blue.cgColor
        okButton.layer.borderWidth = 0.5
        okButton.layer.cornerRadius = 10
        
        logoutButton.layer.borderColor = UIColor.red.cgColor
        logoutButton.layer.borderWidth = 0.5
        logoutButton.layer.cornerRadius = 10
        
        withdrawalButton.layer.borderColor = UIColor.purple.cgColor
        withdrawalButton.layer.borderWidth = 0.5
        withdrawalButton.layer.cornerRadius = 10
        
        pictureSelect.layer.borderColor = UIColor.purple.cgColor
        pictureSelect.layer.borderWidth = 0.5
        pictureSelect.layer.cornerRadius = 10
        
        nicknameTextField.layer.borderColor = UIColor.black.cgColor
        nicknameTextField.layer.borderWidth = 0.5
        nicknameTextField.layer.cornerRadius = 10
        
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        
        newpasswordTextField.layer.borderColor = UIColor.black.cgColor
        newpasswordTextField.layer.borderWidth = 0.5
        newpasswordTextField.layer.cornerRadius = 10
        
        newpasswordVerifyTextField.layer.borderColor = UIColor.black.cgColor
        newpasswordVerifyTextField.layer.borderWidth = 0.5
        newpasswordVerifyTextField.layer.cornerRadius = 10
        
        contentTextField.layer.borderColor = UIColor.black.cgColor
        contentTextField.layer.borderWidth = 0.5
        contentTextField.layer.cornerRadius = 10
        
        profile_image.layer.borderColor = UIColor.black.cgColor
        profile_image.layer.borderWidth = 0.1
        profile_image.layer.cornerRadius = 10
        
        
    }
}
