//
//  PreviewPresenter.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import Foundation
import Photos

final class PreviewPresenter: PreviewPresenterProtocol {
    
    private var selected: Int
    private let fetchResult: PHFetchResult<PHAsset>
    private let router: Wireframe
    init(selected: Int, fetchResult: PHFetchResult<PHAsset>, router: Wireframe) {
        self.selected = selected
        self.fetchResult = fetchResult
        self.router = router
    }

    weak var output: Output?
    
    func start() {
        output?.select(at: selected)
    }
    
    func numberOfItems() -> Int {
        return fetchResult.count
    }
    
    func item(at index: Int) -> PHAsset? {
        guard index < numberOfItems() else { return nil }
        return fetchResult.object(at: index)
    }
    
    func select(at index: Int) {
        selected = index
    }
    
    func close() {
        router.dismiss()
    }
    
}
