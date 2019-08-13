//
//  SubMasterTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/13/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class SubMasterTableViewController: UITableViewController {
    let cellID = CellIDs.DemoCellID.rawValue
    let masterCellID = CellIDs.MasterCellID.rawValue
    
    let subEngine = SubTableViewEngine()
    
    override func loadView() {
        super.loadView()
        registerTableViewCells()
        setupDelegateAndDataSources()
    }
}

fileprivate extension SubMasterTableViewController {
    func setupDelegateAndDataSources() {
        subEngine.showDelegate = self
        tableView.dataSource = subEngine
        tableView.delegate = subEngine
    }
    
    func registerTableViewCells() {
        // Note you can add as many tableview cells as your different content vc's will use. This is the only place you need to load them since the tableviews referenced in the datasource classes will know what these are.
        tableView.register(DemoSubCell.self, forCellReuseIdentifier: cellID)
    }
}

extension SubMasterTableViewController: ShowAllDetails {
    func showDetailView() {
        guard let detailVC = CoreServices.shared.detailView,
            let detailNav = detailVC.navigationController,
            let split = splitViewController else {
                fatalError("This is an unacceptable state")
        }
        split.showDetailViewController(detailNav, sender: nil)
    }
}
