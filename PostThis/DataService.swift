//
//  DataService.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/23/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


class Dataservice {
    
    static let ds = Dataservice()
    
    // Database references
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")

    //Storage References
    //post-pics is the name of the storage folder in Firebase Storage
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE:FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS:FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS:FIRDatabaseReference{
        return _REF_USERS
    }
    
    var REF_POST_IMAGES: FIRStorageReference{
        return _REF_POST_IMAGES
    }
    
    var REF_USER_CURRENT:FIRDatabaseReference{
        let uid = KeychainWrapper.stringForKey(KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func createFirebaseDBUser(uid: String , userData: Dictionary<String,String>)  {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
