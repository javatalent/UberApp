//
//  Container.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

class Container<T> {
    typealias handler = (T) -> Void
    var listener : handler?
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(value : T) {
        self.value = value
    }
    
    func bind(listener : @escaping handler) {
        self.listener = listener
        self.listener?(self.value)
    }
}
