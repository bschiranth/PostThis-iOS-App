//
//  LoginView.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/22/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit

class LoginView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //for shadows
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.0
        layer.shadowRadius  = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
