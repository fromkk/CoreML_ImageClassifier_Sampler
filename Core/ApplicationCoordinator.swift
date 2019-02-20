//
//  ApplicationCoordinator.swift
//  Core
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

public protocol ApplicationCoordinatorProtocol {
    init(window: UIWindow)
    func start()
}
