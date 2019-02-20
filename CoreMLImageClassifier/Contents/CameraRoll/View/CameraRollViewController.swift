//
//  CameraRollEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core
import Photos

final class CameraRollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, Injectable, CameraRollPresenterOutput {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter.title
        
        view.backgroundColor = .white
        view.addSubviewWithMatch(collectionView)
        view.addSubviewWithMatch(noPhotosView)
        view.addSubviewWithMatch(noPermissionsView)
        
        presenter.start()
    }
    
    private var numberOfCols: CGFloat = 3
    private var spacing: CGFloat = 4.0
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let size: CGFloat = floor((view.bounds.size.width - (numberOfCols - 1) * spacing) / numberOfCols)
        cellItemSize = CGSize(width: size, height: size)
        
        let estimatedItemSize = CGSize(width: size, height: size)
        layout.itemSize = estimatedItemSize
        layout.estimatedItemSize = estimatedItemSize
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.register(CameraRollViewCell.nib(), forCellWithReuseIdentifier: CameraRollViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    typealias Dependency = CameraRollPresenterProtocol
    private var presenter: CameraRollPresenterProtocol!
    func inject(_ dependency: Dependency) {
        self.presenter = dependency
    }
    
    private lazy var imageManager: PHImageManager = PHCachingImageManager.default()
    
    private var cellItemSize: CGSize?
    
    // MARK: CameraRollPresenterOutput
    
    private lazy var noPhotosView: CameraRollNoPhotosView = {
        let view = CameraRollNoPhotosView.instantiate()
        view.isHidden = true
        return view
    }()
    func showNoPhotosView() {
        noPhotosView.isHidden = false
    }
    
    func hideNoPhotosView() {
        noPhotosView.isHidden = true
    }
    
    private lazy var noPermissionsView: CameraRollNoPermissionView = {
        let view = CameraRollNoPermissionView.instantiate()
        view.isHidden = true
        return view
    }()
    func showNoPermissionView() {
        noPermissionsView.isHidden = false
    }
    
    func hideNoPermissionView() {
        noPermissionsView.isHidden = true
    }
    
    func refresh() {
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CameraRollViewCell.dequeue(collectionView, for: indexPath)
        if let asset = presenter.item(at: indexPath.row), let itemSize = cellItemSize {
            cell.configure(asset, andManager: imageManager, andTargetSize: CGSize(width: itemSize.width * UIScreen.main.scale, height: itemSize.height * UIScreen.main.scale))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.select(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = floor((view.bounds.size.width - (numberOfCols - 1) * spacing) / numberOfCols)
        return CGSize(width: size, height: size)
    }
}
