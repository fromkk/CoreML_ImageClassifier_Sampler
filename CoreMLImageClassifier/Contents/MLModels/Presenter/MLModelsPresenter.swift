//
//  MLModelsPresenter.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation

final class MLModelsPresenter: MLModelsPresenterProtocol, MLModelsInteractorOutput {
    private let interactor: Interactor
    private let router: Wireframe
    init(interactor: Interactor, router: Wireframe) {
        self.interactor = interactor
        self.router = router
    }

    weak var output: Output?
    
    func start() {
        interactor.fetch()
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> MLModelItem? {
        guard index < numberOfItems() else { return nil }
        return items[index]
    }
    
    func select(_ item: MLModelItem) {
        router.pushCamerarollView(with: item)
    }
    
    private var items: [MLModelItem] = []
    func mlModelsInteractor(_ results: [MLModelItem]) {
        items = results
    }
}
