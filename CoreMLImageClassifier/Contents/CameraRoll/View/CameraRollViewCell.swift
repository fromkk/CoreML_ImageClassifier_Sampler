//
//  CameraRollViewCell.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core
import Photos

final class CameraRollViewCell: UICollectionViewCell, UICollectionViewCellReusable, UINibInstantitable {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    private weak var asset: PHAsset?
    
    func configure(_ asset: PHAsset, andManager imageManager: PHImageManager, andTargetSize targetSize: CGSize) {
        self.asset = asset
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] (image, _) in
            guard let self = self, asset.isEqual(self.asset) else { return }
            self.imageView.image = image
        }
    }
}
