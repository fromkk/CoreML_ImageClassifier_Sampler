//
//  ApplicationCoordinator.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core

final class ApplicationCoordinator: ApplicationCoordinatorProtocol {
    
    private weak var window: UIWindow?
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = MLModelsViewController()
        
        let interactor = MLModelsInteractor()
        let router = MLModelsWireframe(viewController: viewController)
        let presenter = MLModelsPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.inject(presenter)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
    
}
