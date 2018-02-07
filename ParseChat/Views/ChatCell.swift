//
//  ChatCell.swift
//  ParseChat
//
//  Created by Farid Ramos on 2/5/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
