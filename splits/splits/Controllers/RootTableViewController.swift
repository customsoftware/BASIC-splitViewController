//
//  RootTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol KeepDetailAlive: UIViewController {}

class RootTableViewController: UITableViewController {
    let cellID = "DemoCellID"
    let segueID = "pushDetail"
    let branchSegueID = "pushBranch"
    
    var detailDelegate: KeepDetailAlive?
    
    static var collapseDetailViewController = true
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Test Master"
        tableView.register(DemoCell.self, forCellReuseIdentifier: cellID)
        splitViewController?.delegate = self
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
        return TestDetails.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoCell
        cell.controllingEnum = TestDetails.allCases[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        switch passedEnum {
        case .exampleOne, .exampleTwo:
            CoreServices.shared.setActiveDetail(passedEnum)
            showDetailView()
        case .exampleThree:
            pushToSubTable()
        }
    }
}

fileprivate extension RootTableViewController {
    func pushToSubTable() {
        CoreServices.shared.setActiveDetail(nil)
        performSegue(withIdentifier: branchSegueID, sender: nil)
    }
}

extension RootTableViewController: ShowAllDetails {
    func showDetailView() {
        guard let detailVC = detailDelegate,
            let detailNav = detailVC.navigationController,
            let split = splitViewController else {
                fatalError("This is an unacceptable state")
        }

        split.showDetailViewController(detailNav, sender: nil)
    }
}

extension RootTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller.
        return RootTableViewController.collapseDetailViewController
    }
}
