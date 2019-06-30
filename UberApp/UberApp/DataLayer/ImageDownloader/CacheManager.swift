//
//  CacheManager.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit

class CacheManager: NSObject {
    static let cache = NSCache<NSString, UIImage>()
    class func cacheImage(url: String) -> UIImage? {
        return CacheManager.cache.object(forKey: url as NSString)
    }
    
    class func setCacheImage(_ image: UIImage?,_ url: String) {
        if let newImage = image {
            CacheManager.cache.setObject(newImage, forKey: url as NSString)
        }
    }
}

