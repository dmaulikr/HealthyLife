//
//  FirebaseClient.swift
//  HealthyLife
//
//  Created by Duy Nguyen on 31/7/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Firebase

class FirebaseClient {
    
    static let sharedInstance = FirebaseClient()
    
    static let reference =  FIRDatabase.database().reference()
    static let storageRef = FIRStorage.storage().reference()
    
    static let currentUser = FIRAuth.auth()?.currentUser
    static var currentUserID : String! {
        get {
            if let uid = FirebaseClient.currentUser?.uid {
                return uid
            }
            return ""
        }
    }
    
    static var userRef = reference.child("users").child(currentUserID)
    
    static func setup() {
        
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }
}
