//
//  DataService.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/23/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class Dataservice {
    
    static let ds = Dataservice()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")

    var REF_BASE:FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS:FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS:FIRDatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String , userData: Dictionary<String,String>)  {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
