//
//  ResultTableViewCell.swift
//  Battle-Royal
//
//  Created by 이재성 on 2017. 6. 15..
//  Copyright © 2017년 유하늘. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultName: UILabel!
    @IBOutlet weak var resultMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
