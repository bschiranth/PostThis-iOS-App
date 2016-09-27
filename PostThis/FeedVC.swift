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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageOutlet: UIImageView!

    //cache needs to be accessible throughout all classes
    static var imageCache: NSCache<NSString,UIImage> =  NSCache()
    
    var posts = [Post]() // array of user posts data
    
    var imagePicker:UIImagePickerController! // to pick the image from mobile
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        //.value can be .added,.removed,.changed, etc
        Dataservice.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            self.posts = [] // clear the posts array
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                print("ERROR: Error while setting downloaded image")
                cell.configureCell(post: post) // image default nil
                return cell
            }
            
            
        } else {
            return PostCell()
        }
    }
    // image picker view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            addImageOutlet.image = image //set the chosen image to image button
        }else{
            print("IMG: Error while picking the image")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // image picker pressed
    @IBAction func imgPickerPresssed(_ sender: AnyObject) {
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //post image
    @IBAction func postImagedPressed(_ sender: AnyObject) {
    }
    
    //sign out
    @IBAction func signOutPressed(_ sender:AnyObject){
        let keychainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
        print("Keychain removed: \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    /////
}
