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
    
    @IBOutlet weak var likeImg: UIImageView!
    
    var post : Post!
    
    
    var likesRef:FIRDatabaseReference!
        
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    
    //set the UI with Post object data recieved
    // if there is no image it will default to nill
    func configureCell(post:Post, img: UIImage? = nil){
        
           likesRef =  Dataservice.ds.REF_USER_CURRENT.child("likes").child(post.postId)
        
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
        
 
        likesRef.observeSingleEvent(of: .value,with:{(snapshot) in
        
            //use NSNull for firebase not nil
            if let _ =  snapshot.value as? NSNull{
                self.likeImg.image = UIImage(named: "empty-heart")
            }else{
               self.likeImg.image = UIImage(named: "filled-heart")
            }
            
        })
    }

    //like tap
    func likeTapped(sender:UITapGestureRecognizer)  {
        likesRef.observeSingleEvent(of: .value,with:{(snapshot) in
            
            //use NSNull for firebase not nil
            if let _ =  snapshot.value as? NSNull{
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            }else{
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
            
        })

    }

}
