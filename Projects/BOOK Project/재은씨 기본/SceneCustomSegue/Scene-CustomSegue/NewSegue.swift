//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by 이재성 on 2017. 6. 14..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit

class NewSegue : UIStoryboardSegue {
    
    override func perform() {
        //세그웨이 출발지 뷰 컨트롤러
        let srcUVC = self.source
        
        //세그웨이 도착지 뷰 컨트롤러
        let destUVC = self.destination
        
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
        
    }
}
