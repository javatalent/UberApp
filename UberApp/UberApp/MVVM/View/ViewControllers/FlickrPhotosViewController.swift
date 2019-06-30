//
//  FlickrPhotosViewController.swift
//  UberApp
//
//  Created by Kushal on 30/06/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import UIKit

class FlickrPhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var loader: UIActivityIndicatorView!
    
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    private let dataSource = FlickerPhotosDataSource()
    
    lazy var viewModel : FlickerPhotosViewModelProtocol = {
        let service: FilckerServiceProtocol = FilckerService(session: URLSession.shared)
        
        let viewModel = FlickerPhotosViewModel(service: service, dataSource: dataSource)
        
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bind()
        viewModel.fetchPhotos(query: "Rose")
    }
    
    func bind() {
        viewModel.dataSource?.data.bind(listener: { [weak self](cellViewModels) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        })
        
        viewModel.isLoading.bind { [weak self] (isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self?.loader.startAnimating()
                } else {
                    self?.loader.stopAnimating()
                }
            }
        }
        
        viewModel.error.bind(listener: { [ weak self](error) in
            if let message = error?.localizedDescription {
                self?.showError(message: message)
            }
        })
        
    }
    
    func configView()  {
        self.collectionView.dataSource = self.dataSource
        collectionView.register(UINib(nibName: "CustomReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CustomReusableView")
        configSearchController()
    }
    
    func configSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Queries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
}

extension FlickrPhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            viewModel.fetchPhotos(query: text)
        }
        
    }
}


// MARK: - Collection View Flow Layout Delegate
extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
            viewModel.fetchNextPage()
        }
    }
}


extension FlickrPhotosViewController {
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

