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
    let segueID = "pushDetail"
    let branchSegueID = "pushBranch"
    
    let masterDelegate = RootTableViewDelegate()
    let subMasterDelegate = BranchTableViewDelegate()
    
    var detailDelegate: KeepDetailAlive?
    var mode: ListMode = .master
    
    static var collapseDetailViewController = true
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Test Master"
        tableView.register(DemoCell.self, forCellReuseIdentifier: cellID)
        splitViewController?.delegate = self
        tableView.delegate = masterDelegate
        masterDelegate.showDelegate = self
        subMasterDelegate.showDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier,
            let options = SegueOptions(rawValue: segueID) else { return }
        
        switch options {
        case .pushDetail, .pushAltDetail:
            guard let destNavC = segue.destination as? UINavigationController,
                let destVC = destNavC.topViewController as? DetailViewController else { return }
            
            RootTableViewController.collapseDetailViewController = false
            
            destVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            destVC.navigationItem.leftItemsSupplementBackButton = true
            
        case .pushBranch:
            guard let destVC = segue.destination as? BranchTableViewController else { return }
            destVC.delegate = self
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var retValue = 0
        switch mode {
        case .master:
            retValue = MasterList.allCases.count
        case .detail:
            retValue = TestDetails.allCases.count
        }
        
        return retValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoCell
        switch mode {
        case .master:
            cell.masterEnum = MasterList.allCases[indexPath.row]
        case .detail:
            cell.controllingEnum = TestDetails.allCases[indexPath.row]
        }
        
        
        return cell
    }
    
    @objc
    private func revertToMaster() {
        tableView.delegate = masterDelegate
        
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.title = "Master View"
            self.view.layoutIfNeeded()
            self.mode = .master
            self.tableView.reloadData()
        }
        
        CoreServices.shared.setActiveDetail(nil)
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
        
        UIView.animate(withDuration: 0.8) {
            let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.revertToMaster))
            self.navigationItem.leftBarButtonItem = back
            self.navigationItem.title = "Sub View"
            self.mode = .detail
            self.tableView.reloadData()
        }
        
        CoreServices.shared.setActiveDetail(nil)
        RootTableViewController.collapseDetailViewController = false
        tableView.delegate = subMasterDelegate
    }
}

extension RootTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller.
        return RootTableViewController.collapseDetailViewController
    }
}
