//
//  DetailTableViewCell.swift
//  MemoAlone_custom
//
//  Created by jaeseong Lee on 2017. 7. 11..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameInput: UILabel!
    @IBOutlet weak var phoneInput: UILabel!
    @IBOutlet weak var whereInput: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
