//
//  PostCell.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/23/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    
    var post : Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    //set the UI with Post object data recieved
    // if there is no image it will default to nill
    func configureCell(post:Post, img: UIImage? = nil){
        
        self.post = post
        self.caption.text = post.caption
        self.likeLabel.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        }else {
           
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ERROR: Download error from Firebase Storage")
                }else {
                    print("SUCCESS: Image successfully downloaded")
                    if let imgData = data{
                        //cast it to UIImage
                        if let img = UIImage(data: imgData){
                            //set the downloaded image
                            self.postImg.image = img
                            //save image to cache
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
                
                
            })//completion handler
            
        }
        
    }

   

}
