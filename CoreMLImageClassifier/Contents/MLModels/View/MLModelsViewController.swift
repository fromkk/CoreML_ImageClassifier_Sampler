//
//  MLModelsEntity.swift
//  Famm
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit
import Core

final class MLModelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Injectable, MLModelsPresenterOutput {
    
    private let reuseIdentifier: String = "Cell"
    
    override func loadView() {
        super.loadView()
        
        title = "MLModels"
        
        view.addSubview(tableView) {
            [
                tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
                tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    typealias Dependency = MLModelsPresenterProtocol
    private var presenter: MLModelsPresenterProtocol!
    func inject(_ dependency: Dependency) {
        self.presenter = dependency
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = presenter.item(at: indexPath.row)?.rawValue
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.item(at: indexPath.row) else { return }
        presenter.select(item)
    }
}
