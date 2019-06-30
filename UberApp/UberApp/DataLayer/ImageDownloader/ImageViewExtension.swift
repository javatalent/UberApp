//
//  ImageViewExtension.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(url: String?,_ placeholderImage: UIImage? = nil){
        ImageDownloader.setImage(self, url ?? "", placeholderImage)
    }
}
