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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        DataStore.sharedInstance.fetchInitialPhotos() { error in
            if (error == nil) {
                self.collectionView.reloadData()
            }
        }
    }

    @objc private func refreshData(_ sender: Any) {
        DataStore.sharedInstance.clear()
        DataStore.sharedInstance.fetchInitialPhotos() { error in
            if (error == nil) {
                self.collectionView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
}

//MARK: Pagination
extension PhotoViewController {
 
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if DataStore.sharedInstance.getDataCount() > 0 &&
            !isNextPageLoading &&
            distanceFromBottom < height + 100 {
            isNextPageLoading = true
            DataStore.sharedInstance.fetchNextPage() { (fetchedItemCount, error) in
                if (error == nil) {
                    self.addNewItems(fetchedItemCount)
                } else {
                    self.isNextPageLoading = false
                }
            }
        }
    }
    
    private func addNewItems(_ fetchedItemCount: Int) {
        let count = DataStore.sharedInstance.getDataCount()
        let firstIndex = count - fetchedItemCount
        let lastIndex = firstIndex + (fetchedItemCount - 1)
        let indexPaths = Array(firstIndex...lastIndex).map { IndexPath(item: $0, section: 0) }
        
        collectionView.performBatchUpdates({ () -> Void in
            self.collectionView.insertItems(at: indexPaths)
        }, completion: { (finished) -> Void in
            self.isNextPageLoading = false
        });
    }
    
}

// MARK: - UICollectionViewDataSource
extension PhotoViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return DataStore.sharedInstance.getDataCount()
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
