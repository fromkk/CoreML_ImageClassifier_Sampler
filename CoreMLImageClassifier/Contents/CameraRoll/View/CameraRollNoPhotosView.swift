//
//  CameraRollNoPhotosView.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core

final class CameraRollNoPhotosView: UIView, UINibInstantitable {
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = Localizations.CameraRoll.NoPhotos.localized()
        }
    }
}
