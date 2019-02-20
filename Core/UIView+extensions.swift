//
//  UIView+extensions.swift
//  Core
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

public extension UIView {
    public func addSubview(_ view: UIView, constraints: () -> [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(constraints())
    }
    
    public func addSubviewWithMatch(_ view: UIView) {
        addSubview(view) {
            [
                view.widthAnchor.constraint(equalTo: widthAnchor),
                view.heightAnchor.constraint(equalTo: heightAnchor),
                view.centerXAnchor.constraint(equalTo: centerXAnchor),
                view.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
        }
    }
}
