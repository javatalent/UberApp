//
//  Photos.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

struct Photos : Codable {
    let page: UInt
    let pages: UInt
    let perpage: UInt
    let total: String
    var photo: [Photo]
}
