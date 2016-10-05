//
//  Post.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/24/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postId: String! //key of the post in firebase
    private var _postRef: FIRDatabaseReference!
    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postId : String {
        return _postId
    }
    
    init(caption:String,imageUrl:String,likes:Int) {
        self._caption  = caption
        self._imageUrl = imageUrl
        self._likes =  likes
      
    }
    
    init(postId:String, postData: Dictionary<String,AnyObject>) {
        self._postId = postId
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let likes = postData["likes"] as? Int{
            self._likes  = likes
        }
        
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        
        _postRef = Dataservice.ds.REF_POSTS.child(_postId)
    }
    
    func adjustLikes(addLike:Bool)  {
        if addLike{
            _likes = _likes + 1
        }else{
            _likes = _likes - 1
        }
        _postRef.child("likes").setValue(_likes)
        
    }
}
