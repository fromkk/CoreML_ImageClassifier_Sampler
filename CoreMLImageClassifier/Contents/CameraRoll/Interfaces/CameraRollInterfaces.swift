//
//  CameraRollEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Photos

enum CameraRollAuthorizeStatus {
    case notDetermined
    case allowed
    case denied
}

protocol CameraRollInteractorProtocol {
    typealias Output = CameraRollInteractorOutput
    var output: Output? { get set }
    
    var authorizeStatus: CameraRollAuthorizeStatus { get }
    func requestAuthorize(_ completion: @escaping (CameraRollAuthorizeStatus) -> Void)
    
    func fetch()
}

protocol CameraRollInteractorOutput: class {
    func cameraRollInteractor(_ result: PHFetchResult<PHAsset>)
}

protocol CameraRollPresenterProtocol {
    typealias Interactor = CameraRollInteractorProtocol
    typealias Wireframe = CameraRollWireframeProtocol
    init(mlModel: MLModelItem, interactor: Interactor, router: Wireframe)

    typealias Output = CameraRollPresenterOutput
    var output: Output? { get set }
    var title: String { get }
    
    func start()
    func numberOfItems() -> Int
    func item(at index: Int) -> PHAsset?
    func select(at index: Int)
}

protocol CameraRollPresenterOutput: class {
    func showNoPhotosView()
    func hideNoPhotosView()
    func showNoPermissionView()
    func hideNoPermissionView()
    func refresh()
}

protocol CameraRollWireframeProtocol {
    init(viewController: UIViewController)
    
    func showPreview(_ fetchResult: PHFetchResult<PHAsset>, at index: Int, and mlModel: MLModelItem)
}
