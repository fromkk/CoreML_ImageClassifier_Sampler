//
//  MLModelsInteractor.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

final class MLModelsInteractor: MLModelsInteractorProtocol {
    var output: Output?
    
    func fetch() {
        output?.mlModelsInteractor(MLModelItem.allCases)
    }
}
