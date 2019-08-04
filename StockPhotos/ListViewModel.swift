

import UIKit

final class ListViewModel {
    
    var apiClient: ApiClient
    var photoData: PhotoData?
    var isNextPageLoading = false
    
    required init() {
        apiClient = ApiClient()
    }
    
    func clear() {
        photoData = nil
    }
    
    func fetchInitialPhotos(_ completion: @escaping (Error?) -> Void) {
        apiClient.fetchImages(1, 30) {(_ data, _ error) in
            if (error == nil) {
                self.photoData = data
            }
            completion(error)
        }
    }
    
    func getDataCount() -> Int {
        if let photoData = photoData {
            return photoData.data.count * photoData.page
        }
        return 0
    }
    
    func getPhoto(_ index: Int) -> Thumb? {
        return photoData?.data[index].assets.preview1000
    }
    
    func checkNextPages(_ scrollView: UIScrollView, _ collectionView: UICollectionView) {
        if isDataLoadable(scrollView) {
            isNextPageLoading = true
            fetchNextPage() { (fetchedItemCount, error) in
                if (error == nil) {
                    self.addNewItems(fetchedItemCount, collectionView)
                } else {
                    self.isNextPageLoading = false
                }
            }
        }
    }
    
    private func isDataLoadable(_ scrollView: UIScrollView) -> Bool {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        return getDataCount() > 0 &&
            !isNextPageLoading &&
            distanceFromBottom < height + 100
    }
    
    private func addNewItems(_ fetchedItemCount: Int, _ collectionView: UICollectionView) {
        let count = getDataCount()
        let firstIndex = count - fetchedItemCount
        let lastIndex = firstIndex + (fetchedItemCount - 1)
        let indexPaths = Array(firstIndex...lastIndex).map { IndexPath(item: $0, section: 0) }
        
        collectionView.performBatchUpdates({ () -> Void in
            collectionView.insertItems(at: indexPaths)
        }, completion: { (finished) -> Void in
            self.isNextPageLoading = false
        });
    }
    
    private func fetchNextPage(_ completion: @escaping (_ fetchedItemCount: Int, _ error: Error?) -> Void) {
        if let photoData = photoData {
            if (photoData.data.count >= photoData.totalCount) {
                completion(0, nil)
                return
            }
            let itemCount = 15
            let initialPageNumber = photoData.page * photoData.data.count / itemCount
            apiClient.fetchImages(initialPageNumber + 1, itemCount) {(_ data, _ error) in
                if (error == nil) {
                    self.photoData?.data.append(contentsOf: data!.data)
                }
                completion(itemCount, error)
            }
        }
    }
}
