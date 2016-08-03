//
//  foodModel.swift
//  HealthyLife
//
//  Created by admin on 7/27/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Foundation
import Firebase

class Food {
    private var FoodRef: FIRDatabaseReference!
    
    private var FoodKey = ""
    private var FoodDes = ""
    private var Love = 0
    private var Time = NSDate()
    
    static var ChildRef = FirebaseClient.userRef.child("food_journal")
    
    var foodKey: String {
        return FoodKey
    }
    
    var foodDes: String {
        return FoodDes
    }
    
    var love: Int {
        return Love
    }
    
    var time: NSDate {
        return Time
    }
    
    
    static var newKey: String {
        get {
            return ChildRef.childByAutoId().key
        }
    }
    
    var imageRef: FIRStorageReference {
        get {
            // Ex:       gs://healthylife-d0cfe.appspot.com/images/-KO4Wv03fk9VKwOU0oqE
            return FirebaseClient.storageRef.child("images/\(foodKey)")
        }
    }
    
    var loveRef: FIRDatabaseReference {
        get {
            return FirebaseClient.userRef.child("votesLove").child(foodKey)
        }
    }

    
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        
        FoodKey = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let des = dictionary["Description"] as? String {
            FoodDes = des
        }
        
        if let lo = dictionary["Love"] as? Int {
            Love = lo
        }
        
        if let T = dictionary["time"] as? Double {
            Time = NSDate(timeIntervalSince1970: T/1000)
        }
        
        
        // The above properties are assigned to their key.
        
        self.FoodRef = FIRDatabase.database().reference().child("users").child((NSUserDefaults.standardUserDefaults().valueForKey("currentID")) as! String).child("food_journal").child(self.FoodKey)
        FoodRef.keepSynced(true)
    }
    
    func addSubtractLove(addVote: Bool) {
        
        if addVote {
            Love = Love + 1
        } else {
            Love = Love - 1
        }
        
        // Save the new vote total.
        
        FoodRef.child("Love").setValue(Love)
        
    }
    
    static func createNewFood(foodDes: String?) -> Food {
        
        let key =  Food.newKey
        
        let newPost: Dictionary<String, AnyObject> = [
            "ImageUrl": key,
            "Description": foodDes ?? "",
            "time": FIRServerValue.timestamp(),
            "Love": 0,
            ]
        
        Food.ChildRef.child(key).setValue(newPost)
        
        return Food(key: key, dictionary: newPost)
    }
    

    func isLovedFood(withCompletion completion:((Bool) -> ()), needUpdate: Bool) {
        

        loveRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let thumbsUpDown = snapshot.value as? NSNull {
                
                print(thumbsUpDown)

                // Current user hasn't voted for the joke... yet.
                if needUpdate {
                    self.addSubtractLove(true)
                    self.loveRef.setValue(true)
                }
                completion(true)
            } else {
                
                // Current user voted for the joke!
                if needUpdate {
                    
                    self.addSubtractLove(false)
                    self.loveRef.removeValue()
                }
                completion(false)
            }
            
        })
    }
    
}