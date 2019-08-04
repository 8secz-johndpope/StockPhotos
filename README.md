[![Platform](https://img.shields.io/cocoapods/p/SwiftIcons.svg)](http://cocoadocs.org/docsets/SwiftIcons) ![Swift](https://img.shields.io/badge/%20in-swift%204.2-orange.svg) [![Travis](https://img.shields.io/travis/ranesr/SwiftIcons.svg)](https://travis-ci.org/ranesr/SwiftIcons/)

# StockPhotos


![](app_video.gif)


Problem
------
The application was developed because users want to view and select easily stock photos via Shutterstock.

Solution
-------
The application displays the photos in UICollectionView using the Shutterstock photo API and opens the user-selected photo on a new screen.

-------
The solution focuses on mobile (iOS platform). The solution is using Shutterstock API for back-end part.

Third Party Libraries
-------
* [Alamofire](https://github.com/Alamofire/Alamofire) ![](https://img.shields.io/github/stars/Alamofire/alamofire.svg?style=social) - Alamofire - Elegant HTTP Networking in Swift.
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) ![](https://img.shields.io/github/stars/SDWebImage/sdwebimage.svg?style=social) - SDWebImage - Asynchronous image downloader with cache support as a UIImageView category.


Architecture
---------
Model-View-ViewModel

-------
ListViewModel.swift has (var photoData: PhotoData?) variable. The code fetches and appends new datas while scrolling to the variable. This may cause a memory leak when API data grows, although it does not currently cause a problem. In the future, the data would be managed differently.

```Swift

var photoData: PhotoData?

func fetchInitialPhotos(_ completion: @escaping (Error?) -> Void) {
        apiClient.fetchImages(1, 30) {(_ data, _ error) in
            if (error == nil) {
                self.photoData = data
            }
            completion(error)
        }
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

```

Additionally, in the future, can be added more automated tests and can be added search field for stock photos.

Author
-----

Please, check my public profiles and my resume on https://klconur.github.io/



Some iOS applications developed and/or contributed by the author,

* https://apps.apple.com/tr/app/freepark-park-sistemleri/id1253835634?l=tr
* https://apps.apple.com/tr/app/sesli-durak/id1323777806?l=tr
* https://apps.apple.com/tr/app/arvento-race/id718222394?l=tr
* https://apps.apple.com/tr/app/autobuzul-meu/id791513198?l=tr
* https://apps.apple.com/tr/app/arvento-xtreme/id1047176191?l=tr
* https://apps.apple.com/tr/app/arvento/id410513547?l=tr
* https://apps.apple.com/tr/app/arvento-kids-oracle/id1088580890?l=tr
* https://apps.apple.com/tr/app/servisim-nerede/id785390460?l=tr
* https://apps.apple.com/tr/app/ertex-vip-arac-kontrol/id1210641329
