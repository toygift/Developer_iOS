//
//  Aaa.swift
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


class RecipeCreate: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false
    var captureImage: UIImage!
    // video
    var videoURL: URL!
    var data: JSON = JSON.init(rawValue: [])!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var titleTextField: DTTextField!
    @IBOutlet var descriptionTextField: DTTextField!
    @IBOutlet var ingredientTextField: DTTextField!
    @IBOutlet var tagTextField: DTTextField!
    
    let firstNameMessage        = "레시피 제목을 입력해주세요"
    let lastNameMessage         = "레시피 설명을 입력해주세요"
    let emailMessage            = "재료를 입력해 주세요"
    let passwordMessage         = "테그를 입력해주세요"
    
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
    
    @IBAction func nextStep(_ sender: UIButton) {
        guard validateData() else { return }
        createRecipe()
//        fetchRecipe()
        
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: "step") else { return
        }
        
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldBorderColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldBorderColor(){
        titleTextField.borderColor = .clear
        descriptionTextField.borderColor = .clear
        tagTextField.borderColor = .clear
        ingredientTextField.borderColor = .clear
    }

    // Alert
    //
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backToMain(_ segue: UIStoryboardSegue) {
        
    }
}

// 포토라이브러리, 카메라
//
extension RecipeCreate {
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
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 사진, 비디오 취소시
    //
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}


// API연결  ALAMOFIRE FUNC
//
extension RecipeCreate {
    func createRecipe() {
//        guard let token = UserDefaults.standard.string(forKey: "token") else {
//            return
//        }
//        let url = "http://pickycookbook.co.kr/api/recipe/create/"
//        let parameters: Parameters = ["title":self.titleTextField.text!, "description":self.descriptionTextField.text!, "ingredient":self.ingredientTextField.text!,"tag":tagTextField.text!]
//        print("토큰입니다: \(token)")
//        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
//        
//        let call = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//        call.responseJSON { (response) in
//            switch response.result {
//            case .success(let value):
//                print(JSON(value))
//                let recipePK = JSON(value)["pk"].intValue
//                UserDefaults.standard.set(recipePK, forKey: "PK")
//                print(recipePK)
//                print("성공")
//            case .failure(let error):
//                print(JSON(error))
//                print("실패")
//                
//            }
//        }
        
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        
        let url = "http://pickycookbook.co.kr/api/recipe/create/"
        let parameters : [String:Any] = ["title":self.titleTextField.text!, "description":self.descriptionTextField.text!, "ingredient":self.ingredientTextField.text!,"tag":tagTextField.text!, "img_recipe":captureImage]
        let headers: HTTPHeaders = ["Authorization":"token \(token)"]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            for (key, value) in parameters {
                
                if key == "title" || key == "description" || key == "ingredient" || key == "tag" {
                   
                    multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
                } else if let photo = self.captureImage, let imgData = UIImageJPEGRepresentation(photo, 0.25) {
                    multipartFormData.append(imgData, withName: "img_recipe", fileName: "photo.jpg", mimeType: "image/jpg")
                }
                
                
            }//for
            
            
            
        }, to: url, method: .post, headers: headers)
        { (response) in
            switch response {
            case .success(let upload, _, _):
                print("업로드드드드드", upload)
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        print(value)
                        let recipePK = JSON(value)["pk"].intValue
                        print("피케이값을 알려줘라",recipePK)
                        UserDefaults.standard.set(recipePK, forKey: "PK")
                    case .failure(let error):
                        print(error)
                    }
                    print("리스폰스스스스스: ",response)
                    
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}

// TextField Custom
//
extension RecipeCreate {
    
    func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight.height, 0)
    }
    
    func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        
        guard !titleTextField.text!.isEmptyStr else {
            titleTextField.showError(message: firstNameMessage)
            return false
        }
        
        guard !descriptionTextField.text!.isEmptyStr else {
            descriptionTextField.showError(message: lastNameMessage)
            return false
        }
        
        guard !ingredientTextField.text!.isEmptyStr else {
            ingredientTextField.showError(message: emailMessage)
            return false
        }
        
        guard !tagTextField.text!.isEmptyStr else {
            tagTextField.showError(message: passwordMessage)
            return false
        }
        
        return true
    }
    
}
