//
//  PhotoViewCell.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewCell: UICollectionViewCell {
    
    let downloadManager = SDWebImageDownloader()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let photoView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()
    
    var requestCancelled = false
    var thumb: Thumb? {
        didSet {
            if let thumb = thumb {
                loadImage(thumb)
            }
        }
    }
    
    func updateAppearance() {
        addViews()
        setConstraints()
        requestCancelled = false
        photoView.image = nil
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.cornerRadius = 10
    }
    
    func loadImage(_ thumb: Thumb) {
        let url = URL(string: thumb.url)
        downloadManager.downloadImage(with: url, options: SDWebImageDownloaderOptions.allowInvalidSSLCertificates, progress: { (d, d2, d3) in
            
        }, completed: { (image, data, error, status) in
            self.updateContent(image, error)
        })
    }
    
    func cancelOperations() {
        requestCancelled = true
        downloadManager.cancelAllDownloads()
    }
    
    private func updateContent(_ image: UIImage?, _ error: Error?) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.displayPhoto(image, error)
            }
        }
    }
    
    private func displayPhoto(_ image: UIImage?, _ error: Error?) {
        if let image = image {
            showFetchedScreen(image)
        } else if error != nil && !requestCancelled {
            showErrorScreen()
        }
    }
    
    private func showFetchedScreen(_ image: UIImage) {
        photoView.image = image
        loadingIndicator.alpha = 0
        loadingIndicator.stopAnimating()
        backgroundColor = #colorLiteral(red: 0.9338415265, green: 0.9338632822, blue: 0.9338515401, alpha: 1)
        layer.cornerRadius = 10
    }
    
    private func showErrorScreen() {
        photoView.image = UIImage(named: "no_internet")
        loadingIndicator.alpha = 0
        loadingIndicator.stopAnimating()
        backgroundColor = #colorLiteral(red: 0.9338415265, green: 0.9338632822, blue: 0.9338515401, alpha: 1)
        layer.cornerRadius = 10
    }
    
    private func addViews() {
        containerView.addSubview(photoView)
        containerView.addSubview(loadingIndicator)
        self.contentView.addSubview(containerView)
    }
    
}

extension PhotoViewCell {
    
    func setConstraints() {
        setPhotoConstraints()
        setLoadingIndicatorConstraints()
        setContainerConstraints()
    }
    
    private func setPhotoConstraints() {
        photoView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        photoView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        photoView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setLoadingIndicatorConstraints() {
        loadingIndicator.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    private func setContainerConstraints() {
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.95).isActive = true
    }
    
}
