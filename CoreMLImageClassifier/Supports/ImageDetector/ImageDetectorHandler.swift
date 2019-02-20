//
//  ImageDetectorHandler.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation
import Vision

final class ImageDetector: ImageDetectorProtocol {
    var model: MLModel
    
    init(model: MLModel) {
        self.model = model
    }
}
