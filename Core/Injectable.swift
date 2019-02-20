//
//  Injectable.swift
//  Core
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

public protocol Injectable {
    associatedtype Dependency
    func inject(_ dependency: Dependency)
}
