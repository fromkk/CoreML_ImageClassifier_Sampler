//
//  MLModelsWireframe.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

final class MLModelsWireframe: MLModelsWireframeProtocol {
    private weak var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushCamerarollView(with item: MLModelItem) {
        let cameraRollViewController = CameraRollViewController()
        
        let interactor = CameraRollInteractor()
        let router = CameraRollWireframe(viewController: cameraRollViewController)
        let presenter = CameraRollPresenter(mlModel: item, interactor: interactor, router: router)
        interactor.output = presenter
        presenter.output = cameraRollViewController
        cameraRollViewController.inject(presenter)
        
        viewController?.navigationController?.pushViewController(cameraRollViewController, animated: true)
    }
}
