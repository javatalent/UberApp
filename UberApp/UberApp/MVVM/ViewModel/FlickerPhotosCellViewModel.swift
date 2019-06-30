//
//  FlickerPhotosCellViewModel.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

protocol FlickerPhotosCellViewModelProtocol {
    var imageUrl : String {
        get
    }
    init(photo : Photo)
    
    
}

struct FlickerPhotosCellViewModel: FlickerPhotosCellViewModelProtocol {
    
    var photo: Photo
    
    var imageUrl : String {
        return "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
    
}

