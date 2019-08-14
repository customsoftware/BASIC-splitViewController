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
     override func loadView() {
        super.loadView()
        registerTableViewCells()
    }
    
    
    // Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestDetails.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoSubCell
        cell.controllingEnum = TestDetails.allCases[indexPath.row]
        return cell
    }
    
    // Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        CoreServices.shared.setActiveDetail(passedEnum)
        
        guard let detailVC = CoreServices.shared.detailView,
            let detailNav = detailVC.navigationController,
            let split = splitViewController else {
                fatalError("This is an unacceptable state")
        }
        split.showDetailViewController(detailNav, sender: nil)
    }
}

fileprivate extension SubMasterTableViewController {
    
    func registerTableViewCells() {
        // Note you can add as many tableview cells as your different content vc's will use. This is the only place you need to load them since the tableviews referenced in the datasource classes will know what these are.
        tableView.register(DemoSubCell.self, forCellReuseIdentifier: cellID)
    }
}
