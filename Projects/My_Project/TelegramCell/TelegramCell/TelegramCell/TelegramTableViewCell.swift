//
//  TelegramTableViewCell.swift
//  TelegramCell
//
//  Created by jaeseong Lee on 2017. 7. 13..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class TelegramTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIButton!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userComment: UILabel!
    @IBAction func addCell(_ sender:UIButton) {
        //alert띄우거나(TextField 3개) -> 이건 comment부분이 좀 이상할거 같음!
        //따로 뷰 만들어서 하기 . 백그라운드 흐릿?
    }
    
    var twitData: Telegram! { //프로퍼티 옵져버
        didSet {
            self.userName.text = twitData.name
            self.userImage.setImage(UIImage(named: twitData.image), for: UIControlState.normal)
            self.userComment.text = twitData.comment
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
