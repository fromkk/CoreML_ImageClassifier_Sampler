//
//  CameraRollPresenter.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation
import Photos

final class CameraRollPresenter: CameraRollPresenterProtocol, CameraRollInteractorOutput {
    private let mlModel: MLModelItem
    private let interactor: Interactor
    private let router: Wireframe
    init(mlModel: MLModelItem, interactor: Interactor, router: Wireframe) {
        self.mlModel = mlModel
        self.interactor = interactor
        self.router = router
    }

    weak var output: Output?
    
    var title: String { return mlModel.rawValue }
    
    func start() {
        let status = interactor.authorizeStatus
        handle(status)
    }
    
    private func handle(_ status: CameraRollAuthorizeStatus) {
        DispatchQueue.main.async {
            switch status {
            case .allowed:
                self.output?.hideNoPermissionView()
                self.interactor.fetch()
            case .notDetermined:
                self.interactor.requestAuthorize { [weak self] (status) in
                    self?.handle(status)
                }
            case .denied:
                self.output?.showNoPermissionView()
            }
        }
    }
    
    func numberOfItems() -> Int {
        guard let fetchResult = fetchResult else { return 0 }
        return fetchResult.count
    }
    
    func item(at index: Int) -> PHAsset? {
        guard index < numberOfItems() else { return nil }
        return fetchResult?.object(at: index)
    }
    
    func select(at index: Int) {
        guard let fetchResult = fetchResult else { return }
        router.showPreview(fetchResult, at: index, and: mlModel)
    }
    
    private var fetchResult: PHFetchResult<PHAsset>?
    
    func cameraRollInteractor(_ result: PHFetchResult<PHAsset>) {
        fetchResult = result
        
        if 0 < numberOfItems() {
            output?.hideNoPhotosView()
        } else {
            output?.showNoPhotosView()
        }
        
        output?.refresh()
    }
}
