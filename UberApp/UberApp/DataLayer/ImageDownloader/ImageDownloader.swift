//
//  ImageDownloader.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit
class ImageDownloader: NSObject {
    
    static var operations : NSMapTable<UIImageView, BlockOperation> = NSMapTable(keyOptions: NSPointerFunctions.Options.weakMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
    static let serialQueue = DispatchQueue(label: "serialQueue")
    static let operationQueue = OperationQueue()
    
    class func setImage(_ imageView: UIImageView,_ url: String,_ placeholderImage: UIImage? = nil, completion: (()->Void)? = nil) {
        
        ImageDownloader.serialQueue.sync {
            ImageDownloader.operations.object(forKey: imageView)?.queuePriority = .veryLow
            ImageDownloader.operations.object(forKey: imageView)?.cancel()
            ImageDownloader.operations.removeObject(forKey: imageView)
        }
        
        if let image = CacheManager.cacheImage(url: url){
            //If found cache image
            DispatchQueue.main.async {
                imageView.image = image
            }
            
        } else {
            
            let operation = BlockOperation()
            DispatchQueue.main.async {
                imageView.image = placeholderImage
            }
            ImageDownloader.serialQueue.sync {
                ImageDownloader.operations.setObject(operation, forKey: imageView)
            }
            weak var weakOperation = operation
            operation.addExecutionBlock {
                //If operation already cancelled ignore download call
                if !(weakOperation?.isCancelled ?? true) {
                    let image = ImageDownloader.loadImage(urlString: url)
                    DispatchQueue.main.async {
                        //Before setting image again check if operation cancelled
                        if !(weakOperation?.isCancelled ?? true) {
                            imageView.image = image ?? placeholderImage
                            CacheManager.setCacheImage(image, url)
                            completion?()
                            ImageDownloader.serialQueue.sync {
                                ImageDownloader.operations.removeObject(forKey: imageView)
                            }
                        }
                        
                    }
                }
            }
            ImageDownloader.operationQueue.addOperation(operation)
        }
    }
    
    
    
    class func loadImage(urlString: String) -> UIImage? {
        var image : UIImage? = nil
        do {
            if let url = URL(string: urlString) {
                let data = try  Data(contentsOf: url)
                image = UIImage(data: data)
            }
        } catch {
            //print(error)
        }
        return image
    }
    
    
}
