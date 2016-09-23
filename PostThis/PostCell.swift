//
//  PostCell.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/23/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   

}
