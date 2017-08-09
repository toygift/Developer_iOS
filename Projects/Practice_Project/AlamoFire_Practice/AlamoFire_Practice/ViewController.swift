//
//  ViewController.swift
//  AlamoFire_Practice
//
//  Created by jaeseong on 2017. 8. 8..
//  Copyright © 2017년 jaeseong. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var data: JSON = JSON.init(rawValue: [])!
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var contentsTextField: UITextField!
    @IBOutlet var loginIDTextField: UITextField!
    @IBOutlet var loginPWTextField: UITextField!
    
    // 로그인버튼
    @IBAction func logInButton(_ sender: UIButton) {
        self.loginUserData(email: loginIDTextField.text!, password: loginPWTextField.text!)
    }
    
    // 테이블뷰 리로드(삭제해야함)
    @IBAction func fetchUserData(_ sender: UIButton) {
        self.fetchUserData()
    }
    
    // 회원가입 버튼
    @IBAction func createUserData(_ sender: UIButton) {
        self.createUserData(email: emailTextField.text!,
                            nickname: nickNameTextField.text!,
                            password: passwordTextField.text!,
                            passwordConfirm: passwordConfirmTextField.text!)
        
    }
    // 데이터 리프레쉬
    func refreshData() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TableView Method(추후삭제)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    // TableView Method(추후삭제)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as? UserTableViewCell
        
        let pk = self.data[indexPath.row]["pk"].stringValue
        let email = self.data[indexPath.row]["email"].stringValue
        let nickname = self.data[indexPath.row]["nickname"].stringValue
        let contents = self.data[indexPath.row]["content"].stringValue
        let password = self.data[indexPath.row]["password"].stringValue
        
        cell?.pk.text = pk
        cell?.email.text = email
        cell?.nickname.text = nickname
        cell?.contents.text = contents
        cell?.password.text = password
        
        return cell!
    }
    
    // 테이블뷰 리로드(삭제해야함)
    func fetchUserData() {
        Alamofire.request("http://pickycookbook.co.kr/member").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.data = JSON(value)
                self.refreshData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    // 회원가입
    func createUserData(email: String, nickname: String, password: String, passwordConfirm: String) {
        
        
        let url = "http://pickycookbook.co.kr/member/create/"
        let parameters: Parameters = ["email":email, "nickname":nickname, "password1":password, "password2":password]
        let headers : HTTPHeaders = ["Content-Type":"application/json"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            print("포스트: 회원가입")
            
            switch response.result {
                
            case .success(let value):
                
                print("가입성공")
                
                let json = JSON(value)
                print("JSON: \(json)")
                //self.refreshData()
                print("Value \(String(describing: response.value))")
                // 동일아이디 가입시 alert 창 오류메세지 추가!하기
                // response.value?
                // 회원가입 성공
//                let title = "회원가입"
//                let message = "회원가입이 완료 되었습니다"
//                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//                //클로져로 메인화면
//                let ok = UIAlertAction(title: "확인", style: .default, handler: { (alert) in
//                    
//                })
//                
//                alert.addAction(ok)
//                self.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                
                // 회원가입 성공
                let title = "회원가입실패"
                let message = "회원가입이 실패 되었습니다"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //클로져로 메인화면
                let ok = UIAlertAction(title: "확인", style: .default, handler: { (alert) in
                    
                })
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // 로그인
    
    func loginUserData(email: String, password: String) {
        
        let url = "http://pickycookbook.co.kr/member/login/"
        let parameters: Parameters = ["email":email, "password":password]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        print("포스트: 로그인")
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON { (response) in
            
            print("메롱")
            
            switch response.result {
                
            case .success(let value):
                
                print("인증성공")
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                // UserDefaults 에 토큰 저장
                let currentUserToken = json["token"].stringValue
                UserDefaults.standard.set(currentUserToken, forKey: "token")
                
                // 확인
                print(UserDefaults.standard.object(forKey: "token") as! String)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                
                // 로그인 성공
                let title = "로그인"
                let message = "로그인이 완료되었습니다"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //클로져로 메인화면
                let ok = UIAlertAction(title: "확인", style: .default, handler: { (alert) in
                    
                })
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                // 로그인 실패
                let title = "로그인실패"
                let message = "로그인이 실패 되었습니다"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //클로져로 메인화면넘어가게 해야함.
                let ok = UIAlertAction(title: "확인", style: .default, handler: { (alert) in
                    
                })
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                print(error)
                
            }
        }
        
    }
}
