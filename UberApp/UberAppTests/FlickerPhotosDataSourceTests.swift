//
//  FlickerPhotosDataSourceTests.swift
//  UberAppTests
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import XCTest
@testable import UberApp

class FlickerPhotosDataSourceTests: XCTestCase {
    
    var dataSource : FlickerPhotosDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = FlickerPhotosDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: .zero), collectionViewLayout: flowLayout)
        collectionView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        
        // expected zero cells
        
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let photo1 = Photo(id: "48142600047", owner: "182046726", secret: "051d37a460", server: "65535", farm: 66, title: "best simple love spell caster", ispublic: 1, isfriend: 0, isfamily: 0)
        let photo2 = Photo(id: "48142493426", owner: "181947371@N07", secret: "dc47f850fb", server: "65535", farm: 66, title: "Vintage USA Retro Independence Day Patriotic 4th of July shirt", ispublic: 1, isfriend: 0, isfamily: 0)
        
        
        dataSource.data.value = [FlickerPhotosCellViewModel(photo: photo1), FlickerPhotosCellViewModel(photo: photo2)]
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: .zero), collectionViewLayout: flowLayout)
        collectionView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        // giving data value
        let photo1 = Photo(id: "48142600047", owner: "182046726", secret: "051d37a460", server: "65535", farm: 66, title: "best simple love spell caster", ispublic: 1, isfriend: 0, isfamily: 0)
        dataSource.data.value = [FlickerPhotosCellViewModel(photo: photo1)]
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: .zero), collectionViewLayout: flowLayout)
        collectionView.dataSource = dataSource
        collectionView.register(FlickerPhotosCollectionViewCell.self, forCellWithReuseIdentifier: "FlickrCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected CurrencyCell class
        
        guard let _ = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as? FlickerPhotosCollectionViewCell else {
            XCTAssert(false, "Expected CurrencyCell class")
            return
        }
    }
}

