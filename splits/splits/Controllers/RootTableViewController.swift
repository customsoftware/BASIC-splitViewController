//
//  RootTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol KeepDetailAlive: UIViewController {}

enum ListMode {
    case master
    case detail
}

class RootTableViewController: UITableViewController {
    let cellID = "DemoCellID"
    let masterCellID = "MasterCellID"
    
    let masterEngine = MasterTableViewEngine()
    let subEngine = SubTableViewEngine()
    
    var detailDelegate: KeepDetailAlive?
    var mode: ListMode = .master
    
    static var collapseDetailViewController = true
    
    override func loadView() {
        super.loadView()
        tableView.register(DemoMasterCell.self, forCellReuseIdentifier: masterCellID)
        tableView.register(DemoSubCell.self, forCellReuseIdentifier: cellID)
        splitViewController?.delegate = self
        setForMaster()
        masterEngine.showDelegate = self
        subEngine.showDelegate = self
    }
    
    @objc
    private func revertToMaster() {
        CoreServices.shared.setActiveDetail(nil)
        setForMaster()
    }
    
    private func setForMaster() {
        tableView.delegate = masterEngine
        tableView.dataSource = masterEngine
        
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.title = "Master View"
            self.view.layoutIfNeeded()
            self.mode = .master
            self.tableView.reloadData()
        }
    }
    
    private func setForSub() {
        RootTableViewController.collapseDetailViewController = false
        tableView.delegate = subEngine
        tableView.dataSource = subEngine

        UIView.animate(withDuration: 0.8) {
            let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.revertToMaster))
            self.navigationItem.leftBarButtonItem = back
            self.navigationItem.title = "Sub View"
            self.mode = .detail
            self.tableView.reloadData()
        }
    }
}

extension RootTableViewController: ShowAllDetails {
    func showDetailView() {
        guard let detailVC = detailDelegate,
            let detailNav = detailVC.navigationController,
            let split = splitViewController else {
                fatalError("This is an unacceptable state")
        }
        RootTableViewController.collapseDetailViewController = true
        split.showDetailViewController(detailNav, sender: nil)
    }
    
    func pushToSubTable() {
        CoreServices.shared.setActiveDetail(nil)
        setForSub()
    }
}

extension RootTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller.
        return RootTableViewController.collapseDetailViewController
    }
}
