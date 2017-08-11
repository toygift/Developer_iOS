//
//  File.swift
//  Navigation
//
//  Created by jaeseong on 2017. 8. 5..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import Foundation

protocol EditDelegate {
    
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    
}
