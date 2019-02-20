//
//  PreviewWireframe.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

final class PreviewWireframe: PreviewWireframeProtocol {
    
    private weak var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
