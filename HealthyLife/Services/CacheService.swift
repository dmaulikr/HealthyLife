//
//  CacheService.swift
//  HealthyLife
//
//  Created by Duy Nguyen on 2/8/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import Foundation
import Kingfisher

class CacheService {
    
    static let cacheInterval : NSTimeInterval = 432000 // (5 days) 5 * 24 * 60 * 60

    static func setup() {
        
        setupDownloader()
        setupCacheManger()
    }
    
    static func setupDownloader() {
        
        let downloader = KingfisherManager.sharedManager.downloader
        
        // Download process will timeout after 5 seconds. Default is 15.
        downloader.downloadTimeout = 5
        
        // requestModifier will be called before image download request made.
        downloader.requestModifier = {
            (request: NSMutableURLRequest) in
            // Do what you need to modify the download request. Maybe add your HTTP basic authentication for example.
        }
        
        // Hosts in trustedHosts will be ignore the received challenge.
        // You can add the host of your self-signed site to it to bypass the SSL.
        // (Do not do it unless you know what you are doing)
        downloader.trustedHosts = Set(["https://firebasestorage.googleapis.com"])
    }
    
    static func setupCacheManger() {
        
        let cache = KingfisherManager.sharedManager.cache
        
        // Set max disk cache to 50 mb. Default is no limit.
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        
        // Set max disk cache to duration, Default is 1 week.
        cache.maxCachePeriodInSecond = cacheInterval
        
        // Get the disk size taken by the cache.
        cache.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
            //            print("disk size in bytes: \(size)")
        }
    }
    
    static func clearCache() {
        
        let cache = KingfisherManager.sharedManager.cache
        
        // Clear memory cache right away.
        cache.clearMemoryCache()
        
        // Clear disk cache. This is an async operation.
        cache.clearDiskCache()
        
        // Clean expired or size exceeded disk cache. This is an async operation.
        cache.cleanExpiredDiskCache()
    }
}