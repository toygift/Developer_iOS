//
//  UploadViewController.swift
//  AlamoFire_Practice
//
//  Created by jaeseong on 2017. 7. 21..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


extension NSMutableData {
    func appendString(_ str: String){
        self.append(str.data(using: .utf8)!)
    }
}

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //imagePicker 띄우기
    //
    @IBAction func uploadImage(_ sender: UIButton) {
        let picker = UIImagePickerController.init()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        DispatchQueue.main.async {
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //imagePicker delegate
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadAlamofire(pickedImage: pickedImage)
            /*let url = URL(string: "http://localhost:1337/upload")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; charset=utf-8; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBody(name: "test", boundary: boundary, data: UIImagePNGRepresentation(pickedImage)!, mimeType: "image/png", filename: "hello.png")
            
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                guard let data = data
                    else { return }
                print("data: \(data)")
                print("response : \(String(describing: response))")
                print("error : \(String(describing: error))")
            }
            task.resume()*/
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
    
    //AlamoFire
    //
    func uploadAlamofire(pickedImage: UIImage) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(UIImagePNGRepresentation(pickedImage)!, withName: "test", fileName: "test.png", mimeType: "image/png")
        },
            to: "http://localhost:1337/upload",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    //AlamoFire에는 필요없는 함수
    //
    func createBody(name : String,
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/**************************************life cycle**************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
/**************************************life cycle**************************************/
}
