//
//  FlickerPhotosViewModelTests.swift
//  UberAppTests
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation
import XCTest
@testable import UberApp

class FlickerPhotosViewModelTests: XCTestCase {
    
    var viewModel : FlickerPhotosViewModelProtocol!
    var dataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>!
    fileprivate var service : MockFlickerService!
    
    override func setUp() {
        super.setUp()
        self.service = MockFlickerService()
        self.dataSource = GenericDataSource<FlickerPhotosCellViewModelProtocol>()
        self.viewModel = FlickerPhotosViewModel(service: service, dataSource: dataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchFlickerPhotos() {
        
        let expectation = XCTestExpectation(description: "Photos fetch")
        
        viewModel.error.bind(listener: { (error) in
            if error != nil {
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        })
        viewModel.dataSource?.data.bind(listener: { (cellViewModels) in
            expectation.fulfill()
            
        })
        
        viewModel.fetchPhotos(query: "rose")
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchNextFlickerPhotos() {
        
        let expectation = XCTestExpectation(description: "Photos fetch")
        viewModel.query = "rose"
        viewModel.error.bind(listener: { (error) in
            if error != nil {
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        })
        viewModel.dataSource?.data.bind(listener: { (cellViewModels) in
            expectation.fulfill()
            
        })
        
        viewModel.fetchNextPage()
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchNoFlickerPhotos() {
        
        let expectation = XCTestExpectation(description: "Photos fetch")
        
        viewModel.error.bind(listener: { (error) in
            if error != nil {
                XCTAssert(false, "")
            }
        })
        viewModel.dataSource?.data.bind(listener: { (cellViewModels) in
            if cellViewModels.isEmpty {
                expectation.fulfill()
            }
        })
        
        viewModel.fetchPhotos(query: "ghvbhjgvhgvhgvhgv")
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    
}

fileprivate class MockFlickerService : FilckerServiceProtocol {
    
    var photoModel : PhotoModel?
    
    func fetchPhotos(query: String , page: UInt, handler: @escaping (Error?, PhotoModel?) -> Void) {
        // giving a sample json file
        var resource = query
        if page != 0 {
            resource += "\(page)"
        }
        guard let data = FileManager.readJson(forResource: resource) else {
            let error = NSError(domain: "com.ios.kushal", code: 1, userInfo: [NSLocalizedDescriptionKey: "No file or data"])
            handler(error,nil)
            return
        }
        
        let decoder = JSONDecoder()
        guard let photoModel = try? decoder.decode(PhotoModel.self, from: data) else {
            let error = NSError(domain: "com.ios.kushal", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to parse response"])
            handler(error, nil)
            return
        }
        
        handler(nil,photoModel)
    }
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: MockFlickerService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}

