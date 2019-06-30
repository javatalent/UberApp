//
//  CustomReusableView.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit

class CustomReusableView: UICollectionReusableView {
    //MARK:- outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- function
    func showLoader(show : Bool){
        if show {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
}

