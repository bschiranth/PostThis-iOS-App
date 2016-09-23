//
//  ViewController.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/21/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.stringForKey(KEY_UID){
            performSegue(withIdentifier: "feed", sender: nil) //if user is already logged in , go to next screen
        }
    }

    @IBAction func fbButtonPressed(_ sender: RoundButton) {
        
        //print("FB1___________________________");
        
        let facebookLogin = FBSDKLoginManager()
        //
       // print("FB2___________________________");
     
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {(result,error) in
           //   print("FB3___________________________");
            if error != nil {
               //   print("FB4___________________________");
                print("PostThisErrorTag : Facebook Login Error DESCRIPTION: \(error)")
            } else if result?.isCancelled == true {
                //if user cancells auth
                //  print("FB5___________________________");
                print("PostThisErrorTag :User rejected authentication: \(error?.localizedDescription)")
            }else{
               //   print("FB6___________________________");
                print("PostThisErrorTag :Auth success")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString) //get the users access token
                self.firebaseAuthenticate(credential) //do firebase authentication after facebook authentication
                }
        //
        }
        //
    }//end of action
    
    //auth firebase with facebook credentials
    func firebaseAuthenticate(_ credential: FIRAuthCredential){
        // (user,error) - completion handler
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("PostThisErrorTag :Firebase Authentication Error :\(error)")
            }else {
                print("PostThisErrorTag :Firebase Auth success")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    
    }
    ///////////////////////
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("TAG: User authenticated successfully")
                    self.completeSignIn(id: (user?.uid)!)
                }else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("TAG: User Creation Error, Please try again later")
                        }else {
                            print("TAG: Auth success with Firebase")
                            self.completeSignIn(id: (user?.uid)!)
                        }
                    })
                }
                //
            })
        }
     //
    }
    ////////
    func completeSignIn(id:String)  {
        let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        print("TAG :Data saved to keychain with \(keychainResult)")
        performSegue(withIdentifier: "feed", sender: nil)
    }
}

