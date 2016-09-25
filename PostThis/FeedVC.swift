//
//  FeedVC.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/22/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var posts = [Post]() // array of user posts data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //.value can be .added,.removed,.changed, etc
        Dataservice.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            //print("FIRTAG: \(snapshot.value)")
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    //print("FIRTAG: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postId: key, postData: postDict)
                        self.posts.append(post)
                    }
                    
                }
            }
            
            self.tableView.reloadData() // refresh table view cells
        })//end of closure
    }

    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.popViewController(animated: true)
    }
    
    /// table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // number of table cells will be number of post objects in posts array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    // returns the cell with data at that indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        return (tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell)!
    }
}
