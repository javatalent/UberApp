//
//  Photo.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: UInt
    let isfriend: UInt
    let isfamily: UInt
}
