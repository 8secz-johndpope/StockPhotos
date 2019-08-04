//
//  ViewController.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 2.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import UIKit

class ListViewController: UICollectionViewController {
    
    var isNextPageLoading = false
    private let refreshControl = UIRefreshControl()

    lazy var viewModel : ListViewModel = {
        let viewModel = ListViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        viewModel.fetchInitialPhotos() { error in
            if (error == nil) {
                self.collectionView.reloadData()
            }
        }
    }

    private func addRefreshControl() {
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        viewModel.clear()
        viewModel.fetchInitialPhotos() { error in
            if (error == nil) {
                self.collectionView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
}

//MARK: Pagination
extension ListViewController {
 
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if viewModel.getDataCount() > 0 &&
            !isNextPageLoading &&
            distanceFromBottom < height + 100 {
            isNextPageLoading = true
            viewModel.fetchNextPage() { (fetchedItemCount, error) in
                if (error == nil) {
                    self.addNewItems(fetchedItemCount)
                } else {
                    self.isNextPageLoading = false
                }
            }
        }
    }
    
    private func addNewItems(_ fetchedItemCount: Int) {
        let count = viewModel.getDataCount()
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
extension ListViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDataCount()
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
extension ListViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoViewCell else { return }
        cell.thumb = viewModel.getPhoto(indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoViewCell else { return }
        cell.cancelOperations()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let thumb = viewModel.getPhoto(indexPath.row)
        if let thumb = thumb {
        let viewController = PhotoViewController()
            viewController.photoUrl = thumb.url
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}
