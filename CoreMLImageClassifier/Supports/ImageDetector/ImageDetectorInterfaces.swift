//
//  ImageDetectorInterfaces.swift
//  CoreMLImageClassifier
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Vision

protocol ImageDetectorProtocol {
    var model: MLModel { get }
    init(model: MLModel)
}

extension ImageDetectorProtocol {
    func detect(_ image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        let start = Date()
        
        let model: VNCoreMLModel
        do {
            model = try VNCoreMLModel(for: self.model)
        } catch {
            completion(nil, error)
            return
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let results = request.results as? [VNClassificationObservation], let classification = results.first else { return }
            completion(classification.identifier + " \(classification.confidence)", nil)
            
            let end = Date()
            
            let log = String(format: "%@ %.2f%% %.2fs", classification.identifier, classification.confidence * 100.0, end.timeIntervalSince1970 - start.timeIntervalSince1970)
            
            debugPrint(log)
        }
        
        guard let ciImage = CIImage(image: image) else { return }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            completion(nil, error)
        }
    }
}
