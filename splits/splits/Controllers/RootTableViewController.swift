//
//  RootTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {
    let cellID = CellIDs.DemoCellID.rawValue
    let masterCellID = CellIDs.MasterCellID.rawValue
    
    let masterEngine = MasterTableViewEngine()
    let subEngine = SubTableViewEngine()
    
    override func loadView() {
        super.loadView()
        registerTableViewCells()
        setupDelegates()
    }
}

fileprivate extension RootTableViewController {
    func setupDelegates() {
        splitViewController?.delegate = self
        masterEngine.showDelegate = self
        subEngine.showDelegate = self
    }
    
    func registerTableViewCells() {
        // Note you can add as many tableview cells as your different content vc's will use. This is the only place you need to load them since the tableviews referenced in the datasource classes will know what these are.
        tableView.register(DemoMasterCell.self, forCellReuseIdentifier: masterCellID)
        tableView.register(DemoSubCell.self, forCellReuseIdentifier: cellID)
    }
    
    @objc
    func revertToMaster() {
        CoreServices.shared.setCurrentMode(.master)
    }
    
    func setForMaster() {
        tableView.delegate = masterEngine
        tableView.dataSource = masterEngine
        
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.title = "Master View"
            self.view.layoutIfNeeded()
            self.tableView.reloadData()
        }
    }
    
    func setForSub() {
        tableView.delegate = subEngine
        tableView.dataSource = subEngine

        UIView.animate(withDuration: 0.8) {
            let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.revertToMaster))
            self.navigationItem.leftBarButtonItem = back
            self.navigationItem.title = "Sub View"
            self.tableView.reloadData()
        }
    }
}

extension RootTableViewController: Responder {
    func stateChanged() {
        guard let mode = CoreServices.shared.activeMode else { return }
        switch mode {
        case .detail:
            setForSub()
            
        case .master:
            setForMaster()
        }
    }
}

extension RootTableViewController: ShowAllDetails {
    func showDetailView() {
        guard let detailVC = CoreServices.shared.detailView,
            let detailNav = detailVC.navigationController,
            let split = splitViewController else {
                fatalError("This is an unacceptable state")
        }
        split.showDetailViewController(detailNav, sender: nil)
    }
    
    func pushToSubTable() {
        CoreServices.shared.setCurrentMode(.detail)
    }
}

extension RootTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller. The activeDetail property will be nil only if we're not showing content.
        return CoreServices.shared.activeDetail == nil
    }
}
