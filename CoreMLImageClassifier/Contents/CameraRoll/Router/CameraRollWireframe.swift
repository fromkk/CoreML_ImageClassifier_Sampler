//
//  CameraRollWireframe.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Photos

final class CameraRollWireframe: CameraRollWireframeProtocol {
    private weak var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showPreview(_ fetchResult: PHFetchResult<PHAsset>, at index: Int, and mlModel: MLModelItem) {
        let previewController = PreviewViewController()
        let router = PreviewWireframe(viewController: previewController)
        
        let presenter = PreviewPresenter(selected: index, fetchResult: fetchResult, router: router)
        presenter.output = previewController
        
        let detector = ImageDetector(model: mlModel.model)
        
        previewController.inject((presenter: presenter, detector: detector))
        
        let navigationController = UINavigationController(rootViewController: previewController)
        viewController?.present(navigationController, animated: true)
    }
}
