//
//  FirebaseClient.swift
//  HealthyLife
//
//  Created by Duy Nguyen on 31/7/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Firebase

class FirebaseClient {
    
    var ref =  FIRDatabase.database().reference()
    let currentUser = FIRAuth.auth()?.currentUser
    let storageRef = FIRStorage.storage().reference()

    static func setup() {
        
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }
}
