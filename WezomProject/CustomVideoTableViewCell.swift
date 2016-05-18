//
//  CustomVideoTableViewCell.swift
//  WezomProject
//
//  Created by Vitya on 5/17/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class CustomVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoDescriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
