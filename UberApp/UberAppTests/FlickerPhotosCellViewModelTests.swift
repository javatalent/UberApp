//
//  FlickerPhotosCellViewModelTests.swift
//  UberAppTests
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation
import XCTest

@testable import UberApp


class FlickerPhotosCellViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUrlForImage() {
        let photo1 = Photo(id: "48142600047", owner: "182046726", secret: "051d37a460", server: "65535", farm: 66, title: "best simple love spell caster", ispublic: 1, isfriend: 0, isfamily: 0)
        XCTAssertEqual(FlickerPhotosCellViewModel(photo: photo1).imageUrl, "https://farm66.static.flickr.com/65535/48142600047_051d37a460.jpg")
    }
}

