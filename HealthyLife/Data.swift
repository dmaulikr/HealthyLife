//
//  Data.swift
//  HealthyLife
//
//  Created by admin on 8/1/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let dataService = DataService()
    
    private var BaseRef = FIRDatabase.database().reference()
    private var UserRef = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
   
    private var FoodJournalRef = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("food_journal")
    
    private var ActivitiesJournalRef = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("activities_journal")
    
    private var ActivitiesPlannedRed = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("activities_planned")
    
    var baseRef: FIRDatabaseReference {
        return BaseRef
    }
    
    var userRef: FIRDatabaseReference{
        return UserRef
    }
    
    var foodJournalRef: FIRDatabaseReference{
        return FoodJournalRef
    }
    
    var activitiesJournalRef: FIRDatabaseReference {
        return ActivitiesJournalRef
    }
    
    var activitiesPlannedRef: FIRDatabaseReference {
        return ActivitiesPlannedRed
    }
    
}

