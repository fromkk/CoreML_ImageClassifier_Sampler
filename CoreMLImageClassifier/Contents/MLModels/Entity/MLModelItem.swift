//
//  MLModelItem.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation
import Vision

enum MLModelItem: String, CaseIterable {
    case GoogLeNetPlaces
    case Inceptionv3
    case MobileNet
    case Resnet50
    case SqueezeNet
    case VGG16
    
    var model: MLModel {
        switch self {
        case .GoogLeNetPlaces:
            return CoreMLImageClassifier.GoogLeNetPlaces().model
        case .Inceptionv3:
            return CoreMLImageClassifier.Inceptionv3().model
        case .MobileNet:
            return CoreMLImageClassifier.MobileNet().model
        case .Resnet50:
            return CoreMLImageClassifier.Resnet50().model
        case .SqueezeNet:
            return CoreMLImageClassifier.SqueezeNet().model
        case .VGG16:
            return CoreMLImageClassifier.VGG16().model
        }
    }
}
