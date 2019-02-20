//
//  CameraRollInteractor.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation
import Photos
import PhotosUI

final class CameraRollInteractor: CameraRollInteractorProtocol {
    var authorizeStatus: CameraRollAuthorizeStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return .allowed
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    func requestAuthorize(_ completion: @escaping (CameraRollAuthorizeStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            completion(self.authorizeStatus)
        }
    }
    
    func fetch() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeAllBurstAssets = true
        fetchOptions.includeAssetSourceTypes = [.typeCloudShared, .typeiTunesSynced, .typeUserLibrary]
        fetchOptions.includeHiddenAssets = false
        
        let fetchResultForAssetCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions)
        guard let assetCollection = fetchResultForAssetCollection.firstObject else { return }
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResultForAsset = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
        output?.cameraRollInteractor(fetchResultForAsset)
    }
    
    var output: Output?
    
}
