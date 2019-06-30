//
//  FlickerPhotosCollectionViewCell.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit

class FlickerPhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var photoImageView: UIImageView!
    
    func configureCell(viewModel: FlickerPhotosCellViewModelProtocol) {
        photoImageView?.setImage(url: viewModel.imageUrl, UIImage(named: "placeholder"))
    }
    
}
