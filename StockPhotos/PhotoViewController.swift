//
//  ViewController.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 2.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController {
    
    var isNextPageLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataStore.sharedInstance.fetchInitialPhotos() { error in
            if (error == nil) {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if DataStore.sharedInstance.getPhotoCount() > 0 &&
            distanceFromBottom < height + 200 &&
            !isNextPageLoading {
            isNextPageLoading = true
            DataStore.sharedInstance.fetchNextPage() { (fetchedItemCount, error) in
                if (error == nil) {
                    self.addNewItems(fetchedItemCount)
                }
                self.isNextPageLoading = false
            }
        }
        print("Scroll: \(distanceFromBottom)")
    }
    
    private func addNewItems(_ fetchedItemCount: Int) {
        let count = DataStore.sharedInstance.getPhotoCount()
        let firstIndex = count - fetchedItemCount
        let lastIndex = firstIndex + (fetchedItemCount - 1)
        let indexPaths = Array(firstIndex...lastIndex).map { IndexPath(item: $0, section: 0) }
        collectionView.insertItems(at: indexPaths)
    }
    
}

// MARK: - UICollectionViewDataSource
extension PhotoViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return DataStore.sharedInstance.getPhotoCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        if let cell = cell as? PhotoViewCell {
            cell.updateAppearance()
        }
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension PhotoViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoViewCell else { return }
        cell.thumb = DataStore.sharedInstance.getPhoto(indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoViewCell else { return }
        cell.cancelOperations()
    }
}
