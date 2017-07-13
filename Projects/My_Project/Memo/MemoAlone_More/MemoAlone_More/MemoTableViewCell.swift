//
//  MemoTableViewCell.swift
//  MemoAlone_More
//
//  Created by jaeseong Lee on 2017. 7. 10..
//  Copyright © 2017년 jaeseong Lee. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

  
    @IBOutlet weak var inputMemoText: UITextView!
    @IBOutlet weak var showDateToday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
