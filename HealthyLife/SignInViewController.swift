//
//  SignInViewController.swift
//  HealthyLife
//
//  Created by admin on 7/26/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase


class SignInViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginButton(sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.debugDescription)
                    Helper.showAlert("Error", message: error?.localizedDescription, inViewController: self)
                } else {
                    print(user)
                    print("User logged in")
                     self.defaults.setBool(true, forKey: "checkID")
                    self.performSegueWithIdentifier("1", sender: self)
                }
            })
        } else {
            Helper.showAlert("Oops", message: "Please fill in all the fields", inViewController: self)
        }
        
    }
    
    @IBAction func SignUpButton(sender: UIButton) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            
            
            defaults.setBool(true, forKey: "checkID")
            
            
            self.performSegueWithIdentifier("1", sender: self)
            
            
        } else {
            // No user is signed in.
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


