//
//  ViewController.swift
//  TwitterDynamicCellPractice
//
//  Created by 박종찬 on 2017. 7. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TwitDynamicCellDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.shared.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TwitDynamicCell = tableView.dequeueReusableCell(withIdentifier: "TwitCell", for: indexPath) as! TwitDynamicCell
        cell.delegate = self
        cell.data = DataCenter.shared.dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func showProfileView(_ cell: TwitDynamicCell) {
        self.performSegue(withIdentifier: "ProfileSegue", sender: cell)
    }
    
    func showTwitImageController(_ cell: TwitDynamicCell) {
        self.performSegue(withIdentifier: "ImageSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            let profileViewController: ProfileViewController = segue.destination as! ProfileViewController
            profileViewController.userId = (sender as! TwitDynamicCell).data.userId
        } else if segue.identifier == "ImageSegue" {
            let imageViewController: FullScreenViewController = segue.destination as! FullScreenViewController
            imageViewController.image = (sender as! TwitDynamicCell).twitImageButton.currentImage
        }
    }
}

