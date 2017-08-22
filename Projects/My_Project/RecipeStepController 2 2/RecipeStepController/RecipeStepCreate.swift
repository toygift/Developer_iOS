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
import Toaster

class RecipeStepCreate: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // MARK: var, let
    //
    var datas: JSON = JSON.init(rawValue: [])!
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var desc : String = ""
    var captureImage: UIImage!
    var cookTime : Int = 0
    var cookTimer : Bool = false
    var videoURL: URL!
    var flagImageSave = false
    
    // MARK: OUTLET
    
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var cookTimerSwitch: RAMPaperSwitch!
    @IBOutlet var cookTimePicker: UIDatePicker!
    
    @IBOutlet var recipeDesc: UIView!
    @IBOutlet var recipeTimer: UIView!
    @IBOutlet var recipeTime: UIView!
    @IBOutlet var recipePicture: UIView!
    @IBOutlet var recipeOk: UIView!
    
    @IBOutlet var buttonPicture: UIButton!
    @IBOutlet var buttonNextStep: UIButton!
    @IBOutlet var buttonComplete: UIButton!
    
    @IBOutlet var testpicker: UILabel!
    @IBOutlet var descLabel:UILabel!
    @IBOutlet var cookTimerLabel: UILabel!
    @IBOutlet var cookTimeLabel:UILabel!
    @IBOutlet var pictureLabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        border()
        //        pkValue = UserDefaults.standard.integer(forKey: "PK")
    }
    
    @IBAction func completeStep(_ sender: UIButton){
        desc = descriptionTextField.text!
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
        { (response) in
            switch response {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        if !(json["title_error"].stringValue.isEmpty) {
                            Toast(text: "제목을 입력하세요").show()
                        } else if !(json["description_error"].stringValue.isEmpty) {
                            Toast(text: "설명을 입력하세요").show()
                        } else if !(json["ingredient_error"].stringValue.isEmpty) {
                            Toast(text: "재료를 입력하세요").show()
                        } else {
                            guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") else { return }
                            self.show(nextViewController, sender: self)
                            print(1235)
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                    
                    print(upload)
                    print(response)
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }
    
    // MARK: SWITCH Action
    //
    
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
    
    // MARK: 데이트픽커
    // 텍스트 필드로 받아야 할거 같은데..
    @IBAction func cookTimePickerAction(_ sender: UIDatePicker){
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "m"
        cookTime = Int(formatter.string(from: datePickerView.date))!
        print(cookTime)
    }
    
    // MARK: 사진불러오기
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
    
    // MARK: 다음스텝 넘어가기
    //
    @IBAction func nextStep(_ sender: UIButton) {
        
        desc = descriptionTextField.text!
        alamo()
        
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

// MARK: ALAMOFIRE
//
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
        { (response) in
            switch response {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        if !(json["title_error"].stringValue.isEmpty) {
                            Toast(text: "제목을 입력하세요").show()
                        } else if !(json["description_error"].stringValue.isEmpty) {
                            Toast(text: "설명을 입력하세요").show()
                        } else if !(json["ingredient_error"].stringValue.isEmpty) {
                            Toast(text: "재료를 입력하세요").show()
                        } else {
                            guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "step") else { return }
                            self.show(nextViewController, sender: self)
                            print(1235)
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                    
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
    
    // MARK: 포토라이브러리, 카메라
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
        }else {
            print("something is worng")
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
extension RecipeStepCreate {
    func border(){
        
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.layer.borderWidth = 0.5
        descriptionTextField.layer.cornerRadius = 10
        
        recipeDesc.layer.borderColor = UIColor.black.cgColor
        recipeDesc.layer.borderWidth = 0.5
        recipeDesc.layer.cornerRadius = 10
        
        recipeTimer.layer.borderColor = UIColor.black.cgColor
        recipeTimer.layer.borderWidth = 0.5
        recipeTimer.layer.cornerRadius = 10
        
        recipeTime.layer.borderColor = UIColor.black.cgColor
        recipeTime.layer.borderWidth = 0.5
        recipeTime.layer.cornerRadius = 10
        
        recipePicture.layer.borderColor = UIColor.black.cgColor
        recipePicture.layer.borderWidth = 0.5
        recipePicture.layer.cornerRadius = 10
        
        recipeOk.layer.borderColor = UIColor.black.cgColor
        recipeOk.layer.borderWidth = 0.5
        recipeOk.layer.cornerRadius = 10
        
        buttonPicture.layer.borderColor = UIColor.black.cgColor
        buttonPicture.layer.borderWidth = 0.5
        buttonPicture.layer.cornerRadius = 10
        
        buttonNextStep.layer.borderColor = UIColor.black.cgColor
        buttonNextStep.layer.borderWidth = 0.5
        buttonNextStep.layer.cornerRadius = 10
        
        buttonComplete.layer.borderColor = UIColor.black.cgColor
        buttonComplete.layer.borderWidth = 0.5
        buttonComplete.layer.cornerRadius = 10
        
        descLabel.layer.borderColor = UIColor.black.cgColor
        descLabel.layer.borderWidth = 0.5
        descLabel.layer.cornerRadius = 10
        
        cookTimerLabel.layer.borderColor = UIColor.black.cgColor
        cookTimerLabel.layer.borderWidth = 0.5
        cookTimerLabel.layer.cornerRadius = 10
        
        cookTimeLabel.layer.borderColor = UIColor.black.cgColor
        cookTimeLabel.layer.borderWidth = 0.5
        cookTimeLabel.layer.cornerRadius = 10
        
        pictureLabel.layer.borderColor = UIColor.black.cgColor
        pictureLabel.layer.borderWidth = 0.5
        pictureLabel.layer.cornerRadius = 10
    }
}
