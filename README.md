# StockPhotos


Problem
------
The application was developed because users want to view and select easily stock photos via Shutterstock.

Solution
-------
The application displays the photos in UICollectionView using the Shutterstock photo API and opens the user-selected photo on a new screen.

-------
The solution focuses on mobile (iOS platform). The solution is using Shutterstock API for back-end part.

-------
ListViewModel.swift has (var photoData: PhotoData?) variable. The code fetches and appends new datas while scrolling to the variable. This may cause a memory leak when API data grows, although it does not currently cause a problem. In the future, the data would be managed differently.

Additionally, in the future, can be added more automated tests and can be added search field for stock photos.

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
