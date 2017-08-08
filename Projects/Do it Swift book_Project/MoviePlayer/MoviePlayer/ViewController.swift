//
//  ViewController.swift
//  MoviePlayer
//
//  Created by jaeseong on 2017. 8. 9..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController {

    @IBAction func playInternal(_ sender: UIButton) {
        
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)

        playVideo(url: url)
        
        
    }
    
    @IBAction func playExternal(_ sender: UIButton) {
        
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Firework.mp4")!
        playVideo(url: url)
        
    }
    
    private func playVideo(url: NSURL) {
        
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }

}

