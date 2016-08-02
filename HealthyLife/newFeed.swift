//
//  newFeed.swift
//  HealthyLife
//
//  Created by admin on 8/1/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Foundation

class Users: NSObject {
    var FeedKey: NSString?
    var username: NSString?
    var avatarImageURL: NSString?
    
    
    init(key: String, dictionary: NSDictionary) {
        FeedKey = key
        username = (dictionary["username"] as? String) ?? "fuck"
        avatarImageURL = (dictionary["avatarURL"] as? String) ?? "fuck"
        
        
        
    }
    
}