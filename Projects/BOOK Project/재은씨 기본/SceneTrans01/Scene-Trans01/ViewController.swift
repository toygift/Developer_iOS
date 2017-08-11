//
//  ViewController.swift
//  Scene-Trans01
//
//  Created by 이재성 on 2017. 6. 13..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func moveNext(_ sender: Any) {
        
        // 여러개의 스토리 보드가 있을경우 이렇게 사용..Main은 스토리보드 파일명
        
        // let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // let uvc = storyboard.instantiateViewController(withIdentifier: "SecondVC")
        
        
        // let uvc = storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        // self.storyboard 값은 옵셔널 타입, 경우에 따라 nil값이 될수도 있음
        // 이값을 nil검사 없이 바로 ! 연산자를 사용하여 강제 해제하였으므로 만약 self.storyboard 값이 nil이라면 오류가 발생. 이를 옵셔널 체인과 옵셔널 바인딩으로 보강하면 다음과 같음
        
        /* if let uvc = storyboard?.instantiateViewController(withIdentifier: "SecondVC"){
                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
                self.present(uvc, animated: true)
            }
        */
        
        //뷰 컨트롤러 인스턴스는 moveNext메소드 전체 실행에서 비어있어서는 안되는 필수조건이기 때문에 guard 조건문으로 필터링
        
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        // 화면 전환할 때의 애니메이션 타입
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        // 인자값으로 뷰컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출
        
        self.present(uvc, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

