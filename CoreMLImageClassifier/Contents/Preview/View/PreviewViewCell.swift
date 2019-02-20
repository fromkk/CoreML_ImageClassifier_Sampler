//
//  PreviewViewCell.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core
import Photos

final class PreviewViewCell: UICollectionViewCell, UICollectionViewCellReusable, UINibInstantitable, UIScrollViewDelegate, Injectable {
    
    // MARK: DI
    
    typealias Dependency = ImageDetectorProtocol
    private var detector: ImageDetectorProtocol!
    func inject(_ dependency: ImageDetectorProtocol) {
        detector = dependency
    }
    
    // MARK: UI
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = nil
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.text = nil
            resultLabel.layer.shadowColor = UIColor.black.cgColor
            resultLabel.layer.shadowOffset = CGSize(width: 0, height: 6)
            resultLabel.layer.shadowRadius = 6.0
            resultLabel.layer.shadowOpacity = 0.5
        }
    }
    
    // MARK: Elements
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        resultLabel.text = nil
    }
    
    private weak var imageManager: PHImageManager?
    
    private weak var asset: PHAsset?
    
    private var imageRequestID: PHImageRequestID?
    
    func cancel() {
        guard let imageRequestID = imageRequestID, let imageManager = imageManager else { return }
        imageManager.cancelImageRequest(imageRequestID)
    }
    
    func configure(_ asset: PHAsset, andManager imageManager: PHImageManager, andTargetSize targetSize: CGSize) {
        defer { self.imageManager = imageManager }
        
        self.asset = asset
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false
        imageRequestID = imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { [weak self] (image, _) in
            guard let self = self, asset.isEqual(self.asset) else { return }
            self.imageView.image = image
            self.imageView.setNeedsLayout()
            self.imageView.layoutIfNeeded()
            
            self.resetScrollView()
            self.resetContentInset()
            self.detect()
        }
    }
    
    private func resetScrollView() {
        guard let image = imageView.image else { return }
        
        let widthScale = scrollView.bounds.width / image.size.width
        let heightScale = scrollView.bounds.height / image.size.height
        let scale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = scale
        scrollView.maximumZoomScale = scale * 3
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    private func resetContentInset() {
        scrollView.contentInset = UIEdgeInsets(top: max((scrollView.frame.height - imageView.frame.height)/2, 0), left: max((scrollView.frame.width - imageView.frame.width)/2, 0), bottom: 0, right: 0)
    }
    
    private func detect() {
        guard let image = imageView.image else { return }
        
        detector.detect(image) { [weak self] (result, error) in
            guard let self = self, image.isEqual(self.imageView.image) else { return }
            self.resultLabel.text = result
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        resetContentInset()
    }
}
