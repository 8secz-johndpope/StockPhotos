//
//  PhotoViewController.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 4.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {

    var photoUrl: String?
    let photoView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(photoView)
        setConstraints()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let photoUrl = photoUrl {
            photoView.sd_setImage(with: URL(string: photoUrl))
        }
    }
    
}

// MARK: Constraints
extension PhotoViewController {
    
    private func setConstraints() {
        photoView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        photoView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        photoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        photoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
}
