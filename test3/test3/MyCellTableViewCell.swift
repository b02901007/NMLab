//
//  MyCellTableViewCell.swift
//  test3
//
//  Created by 呂明峻 on 2017/2/27.
//  Copyright © 2017年 呂明峻. All rights reserved.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var image2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
