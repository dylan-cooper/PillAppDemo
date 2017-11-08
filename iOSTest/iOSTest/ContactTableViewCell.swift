//
//  ContactTableViewCell.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-07.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
    }
}
