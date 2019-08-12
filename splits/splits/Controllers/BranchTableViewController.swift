//
//  BranchTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/10/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class  BranchTableViewController: UITableViewController {
    let cellID = "DemoCellID"
    
    weak var delegate: ShowAllDetails?
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Test Sub-Master"
        tableView.register(DemoCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            CoreServices.shared.setActiveDetail(nil)
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
        CoreServices.shared.setActiveDetail(passedEnum)
        delegate?.showDetailView()
    }
}
