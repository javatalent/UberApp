//
//  FlickerServiceTests.swift
//  UberAppTests
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation
import XCTest
@testable import UberApp

class FlickerServiceTests : XCTestCase{
    var service : FilckerService!
    override func setUp() {
        //        service = FlickerServi
    }
    
    override func tearDown() {
        service = nil
    }
    
    func testUrlForFirstPage() {
        XCTAssertEqual(FilckerService.getFlickrURL(query : "Rose", page: 0), "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&text=Rose&api_key=3e7cc266ae2b0e0d78e279ce8e361736&page=0")
    }
    
}
