//
//  PostTableViewCell.swift
//  MyInstagram
//
//  Created by Paethai Akarajariyakul on 4/17/16.
//  Copyright © 2016 mycompany. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var postImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
