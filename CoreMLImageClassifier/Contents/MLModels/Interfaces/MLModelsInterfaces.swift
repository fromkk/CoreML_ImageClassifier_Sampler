//
//  MLModelsEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

protocol MLModelsInteractorProtocol {
    typealias Output = MLModelsInteractorOutput
    var output: Output? { get set }
    
    func fetch()
}

protocol MLModelsInteractorOutput: class {
    func mlModelsInteractor(_ results: [MLModelItem])
}

protocol MLModelsPresenterProtocol {
    typealias Interactor = MLModelsInteractorProtocol
    typealias Wireframe = MLModelsWireframeProtocol
    init(interactor: Interactor, router: Wireframe)

    typealias Output = MLModelsPresenterOutput
    var output: Output? { get set }
    
    func start()
    func numberOfItems() -> Int
    func item(at index: Int) -> MLModelItem?
    func select(_ item: MLModelItem)
}

protocol MLModelsPresenterOutput: class {}

protocol MLModelsWireframeProtocol {
    init(viewController: UIViewController)
    
    func pushCamerarollView(with item: MLModelItem)
}
