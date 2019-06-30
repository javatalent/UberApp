//
//  ImageDownloaderTests.swift
//  UberAppTests
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import XCTest
@testable import UberApp

class ImageDownloaderTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForFailingToDownload() {
        let expectation = self.expectation(description: "Placeholder image")
        let imageView = UIImageView()
        let placeholderImage = UIImage()
        ImageDownloader.setImage(imageView, "", placeholderImage) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertEqual(imageView.image, placeholderImage)
    }
    
    func testForSuccessfulDownload() {
        let expectation = self.expectation(description: "Placeholder image")
        let imageView = UIImageView()
        ImageDownloader.setImage(imageView, Bundle(for: type(of: self)).url(forResource: "test", withExtension: "jpeg")!.absoluteString, nil) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertNotNil(imageView.image, "Image not downloaded")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

