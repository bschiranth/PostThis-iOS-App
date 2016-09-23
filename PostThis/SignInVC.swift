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

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    @IBAction func fbButtonPressed(_ sender: RoundButton) {
        
        let facebookLogin = FBSDKLoginManager()
        //
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: {(result,error) in
            if error != nil {
                print("PostThisErrorTag : Facebook Login Error DESCRIPTION: \(error)")
            } else if result?.isCancelled == true {
                //if user cancells auth
                print("PostThisErrorTag :User rejected authentication: \(error?.localizedDescription)")
            }else{
                print("PostThisErrorTag :Auth success")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString) //get the users access token
                self.firebaseAuthenticate(credential) //do firebase authentication after facebook authentication
                }
        //
        })
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
            }
        })
    
    }
    ///////////////////////
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("TAG: User authenticated successfully")
                }else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("TAG: User Creation Error, Please try again later")
                        }else {
                            print("TAG: Auth success with Firebase")
                        }
                    })
                }
                //
            })
        }
     //
    }
    ////////
}

