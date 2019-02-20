//
//  PreviewEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/17.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core
import Photos

final class PreviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, Injectable, PreviewPresenterOutput {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = closeButton
        
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubviewWithMatch(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.start()
    }
    
    private lazy var imageManager: PHImageManager = PHCachingImageManager.default()
    
    lazy var closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(onTap(closeButton:)))
    
    @objc private func onTap(closeButton: UIBarButtonItem) {
        presenter.close()
    }
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.register(PreviewViewCell.nib(), forCellWithReuseIdentifier: PreviewViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PreviewViewCell.dequeue(collectionView, for: indexPath)
        cell.inject(detector)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PreviewViewCell else { return }
        
        if let asset = presenter.item(at: indexPath.row) {
            cell.configure(asset, andManager: imageManager, andTargetSize: view.bounds.size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PreviewViewCell else { return }
        cell.cancel()
    }
    
    typealias Dependency = (presenter: PreviewPresenterProtocol, detector: ImageDetectorProtocol)
    private var presenter: PreviewPresenterProtocol!
    private var detector: ImageDetectorProtocol!
    func inject(_ dependency: Dependency) {
        self.presenter = dependency.presenter
        self.detector = dependency.detector
    }
    
    // MARK: PreviewPresenterOutput
    
    func select(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
