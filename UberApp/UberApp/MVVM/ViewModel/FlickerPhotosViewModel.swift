//
//  FlickerPhotosViewModel.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation

protocol FlickerPhotosViewModelProtocol {
    var query : String {get set}
    var dataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>? {get set}
    var photoModel : PhotoModel? {get set}
    var isLoading : Container<Bool> {get set}
    func fetchPhotos(query: String)
    func fetchNextPage()
    var error: Container<Error?> {get set}
    init(service: FilckerServiceProtocol , dataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>)
    
}

class FlickerPhotosViewModel: FlickerPhotosViewModelProtocol {
    
    var dataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>?
    var service: FilckerServiceProtocol
    
    var photoModel: PhotoModel? {
        didSet {
            updateDataSource()
        }
    }
    
    var error: Container<Error?> = Container(value: nil)
    
    var onErrorHandling : ((Error?) -> Void)?
    var page: UInt = 0
    var query: String = ""
    var isRequestingNextPage: Bool = false
    var isLoading: Container<Bool> = Container(value:false)
    
    required init(service: FilckerServiceProtocol , dataSource : GenericDataSource<FlickerPhotosCellViewModelProtocol>) {
        self.dataSource = dataSource
        self.service = service
        
    }
    
    
}

extension FlickerPhotosViewModel {
    func updateDataSource() {
        guard let photos = self.photoModel?.photos?.photo else {
            return
        }
        var cellModels : [FlickerPhotosCellViewModelProtocol] = []
        for photo in photos {
            let cellModel = FlickerPhotosCellViewModel(photo: photo)
            cellModels.append(cellModel)
        }
        self.dataSource?.data.value = cellModels
    }
    
    
    func fetchPhotos(query: String) {
        photoModel = nil
        page = 0
        self.query = query
        
        self.isLoading.value = true
        
        service.fetchPhotos(query: query, page: page) {[weak self] (error, data) in
            self?.isLoading.value = false
            if let error =  error {
                DispatchQueue.main.async {
                    //show error
                    self?.error.value = error
                }
            } else if let photoModel = data {
                self?.photoModel = photoModel
            }
        }
    }
    
    func fetchNextPage() {
        if isRequestingNextPage {
            return
        }
        
        if let count = self.photoModel?.photos?.pages , count == page {
            return
        }
        
        page += 1
        self.isRequestingNextPage = true
        service.fetchPhotos(query: query, page: page) {[weak self] (error, data) in
            self?.isRequestingNextPage = false
            if let error =  error {
                DispatchQueue.main.async {
                    //show error
                    self?.error.value = error
                }
            } else if var photoModel = data {
                if let prevPhotos = self?.photoModel?.photos?.photo {
                    var allPhotos = prevPhotos
                    if let newPhotos = photoModel.photos?.photo {
                        allPhotos.append(contentsOf: newPhotos)
                    }
                    photoModel.photos?.photo = allPhotos
                    
                    self?.photoModel = photoModel
                }
            }
        }
    }
}

