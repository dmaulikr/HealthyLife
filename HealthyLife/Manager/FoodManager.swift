//
//  FoodManager.swift
//  HealthyLife
//
//  Created by Duy Nguyen on 3/8/16.
//  Copyright © 2016 NHD group. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FoodManager {
    
    static func uploadFood(description: String?, image: UIImage?, withCompletion completion:() -> (), failure: (NSError) -> ()) {
        
        //: Upload JSON to realtime database
        
        let newFood = Food.createNewFood(description)
        
        //: Upload Image
        
        guard var foodImage = image else {
            
            completion()
            return
        }
        
        foodImage = foodImage.resizeImage(CGSize(width: 500.0, height: 500.0))
        
        let imageData: NSData = UIImagePNGRepresentation(foodImage)!
        
        // Upload the file to the path ""images/\(key)"
        newFood.imageRef.putData(imageData, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
                failure(error!)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
                print(downloadURL)
                print("does it work")
                completion()
            }
        }
        
    }
    
    
    static func getFoods(limit: UInt, withCompletion completion:(foods: [Food]) -> (), failure: (NSError) -> ()) {
        
        Food.ChildRef.queryLimitedToLast(limit).observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our jokes data.
            
            print(snapshot.value)
            
            var foods = [Food]()
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let food = Food(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        foods.insert(food, atIndex: 0)
                    }
                }
                
            }
            
            completion(foods: foods)
            
            }, withCancelBlock:  { error in
                failure(error)
            }
        )
        
    }
    
    
}