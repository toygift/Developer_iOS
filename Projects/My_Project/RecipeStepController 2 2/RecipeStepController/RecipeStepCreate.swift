//
//  ViewController.swift
//  RecipeStepController
//
//  Created by js on 2017. 8. 18..
//  Copyright © 2017년 sevenTeam. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import AssetsLibrary


class RecipeStepCreate: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var datas: JSON = JSON.init(rawValue: [])!
    
    // imagePicker
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 텍스트필드
    var desc : String = ""
    // 촬영 또는 포토라이브러리에서 불러온 사진 저장할 변수
    var captureImage: UIImage!
    // 조리시간 변수
    var cookTime : Int = 0
    // 타이머사용여부
    var cookTimer : Bool = false
    // video
    var videoURL: URL!
    // BOOL
    var flagImageSave = false
    
    // 아울렛
    @IBOutlet weak var testpicker: UILabel!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var cookTimerSwitch: RAMPaperSwitch!
    @IBOutlet weak var cookTimerLabel: UILabel!
    @IBOutlet weak var cookTimePicker: UIDatePicker!
    
    //    @IBAction func description(_ sender: UIButton) {
    //        desc = descriptionTextField.text
    //        print(desc)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        pkValue = UserDefaults.standard.integer(forKey: "PK")
    }
    
    @IBAction func cookTimerSwitchAction(_ sender: UISwitch){
        self.cookTimerSwitch.animationDidStartClosure = {(onAnimation: Bool) in
            UIView.transition(with: self.cookTimerLabel, duration: self.cookTimerSwitch.duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.cookTimerLabel.textColor = onAnimation ? UIColor.black : UIColor.clear
            }, completion:nil)
        }
        let cookSwitch = sender
        let cookSwitchValue = cookSwitch.isOn
        cookTimer = cookSwitchValue
        print(cookSwitchValue)
    }
    // 데이트픽커
    // 텍스트 필드로 받아야 할거 같은데..
    @IBAction func cookTimePickerAction(_ sender: UIDatePicker){
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "m"
        cookTime = Int(formatter.string(from: datePickerView.date))!
        print(cookTime)
    }
    // 사진불러오기
    //
    @IBAction func pictureUploadButtonAction(_ sender: UIButton){
        
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
    
    // 카메라
    //
    //    @IBAction func cameraUploadButtonAction(_ sender: UIButton) {
    //        media(.camera, flag: true, editing: false)
    //    }
    // 다음스텝 넘어가기
    //
    @IBAction func nextStep(_ sender: UIButton) {
        if (descriptionTextField.text?.isEmpty)! {
            myAlert("확인", message: "설명을 입력해주세요")
        }else {
            desc = descriptionTextField.text!
            alamo()
            
            
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "step") else { return }
            self.show(nextVC, sender: sender)
            print(1235)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: 0, up: true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        moveTextField(textField, moveDistance: 0, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

//Alamofire
//
//extension RecipeStepCreate {
//    func alamo(){
//        guard let token = UserDefaults.standard.string(forKey: "token") else {
//            return
//        }
//        let pkValues = UserDefaults.standard.object(forKey: "PK") as! Int
//        
//        let url = "http://pickycookbook.co.kr/api/recipe/step/create/"
//        let parameters : Parameters = ["recipe":pkValues, "description": desc, "is_timer":cookTimer, "timer":cookTime*60, "img_recipe":captureImage]
//        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
//   }
//}

extension RecipeStepCreate {
    func alamo(){
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let pkValues = UserDefaults.standard.object(forKey: "recipePK") as! Int
        
        let url = "http://pickycookbook.co.kr/api/recipe/step/create/"
        let parameters : [String:Any] = ["recipe":pkValues, "description": desc, "is_timer":cookTimer, "timer":cookTime*60, "img_step":captureImage]
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            for (key, value) in parameters {
               
                if key == "description" || key == "timer" || key == "is_timer" || key == "recipe" {
                    print("됨됨됨 \(value)")
                    
                    multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
                } else if let photo = self.captureImage, let imgData = UIImageJPEGRepresentation(photo, 0.25) {
                    multipartFormData.append(imgData, withName: "img_step", fileName: "photo.jpg", mimeType: "image/jpg")
                }
                
                
            }//for
     
            
            
        }, to: url, method: .post, headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    print(upload)
                    print(response)
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }
}

// func
//

extension RecipeStepCreate {
    // Alert
    //
    
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // 포토라이브러리, 카메라
    //
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
                myAlert("경고", message: "포토라이브러리에 접근할수 없음")
            } else {
                myAlert("경고", message: "카메라에 접근할수 없음")
            }
        }
    }
    
    // 사진, 비디오, 포토라이브러리 선택 끝났을때
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
        }else {
            print("something is worng")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 사진, 비디오 취소시
    //
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
