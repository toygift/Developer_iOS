//
//  ViewController.swift
//  TelegramCell
//
//  Created by jaeseong Lee on 2017. 7. 13..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCentre.shered.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as! TelegramTableViewCell
        
        let data = DataCentre.shered.cellData
        cell.userImage.setImage(UIImage(named: data[indexPath.row].image), for: UIControlState.normal)
//        cell.userName.text = data[indexPath.row].name
//        cell.userComment.text = data[indexPath.row].comment
        cell.twitData = DataCentre.shered.cellData[indexPath.row]
        
        
        return cell
    }


}

