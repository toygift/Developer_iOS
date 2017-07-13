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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
