//
//  PreviewEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Photos

protocol PreviewPresenterProtocol {
    typealias Wireframe = PreviewWireframeProtocol
    init(selected: Int, fetchResult: PHFetchResult<PHAsset>, router: Wireframe)

    typealias Output = PreviewPresenterOutput
    var output: Output? { get set }
    
    func start()
    func close()
    func numberOfItems() -> Int
    func item(at index: Int) -> PHAsset?
    func select(at index: Int)
}

protocol PreviewPresenterOutput: class {
    func select(at index: Int)
}

protocol PreviewWireframeProtocol: class {
    init(viewController: UIViewController)
    
    func dismiss()
}
