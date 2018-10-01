//
//  HomeTableViewCell.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/30/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
