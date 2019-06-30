//
//  FlickerPhotosDataSource.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit


class GenericDataSource<T> : NSObject {
    var data: Container<[T]> = Container.init(value: [])
}

class FlickerPhotosDataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "FlickrCell", for: indexPath) as! FlickerPhotosCollectionViewCell
        cell.configureCell(viewModel: data.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CustomReusableView", for: indexPath) as! CustomReusableView
        view.showLoader(show:  !data.value.isEmpty)
        return view
    }
}

