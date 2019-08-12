//
//  BranchTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/10/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol ShowAllDetails: UIViewController {
    func showDetailView()
}

class  BranchTableViewController: UITableViewController {
    let cellID = "DemoCellID"
    
    weak var delegate: ShowAllDetails?
    var hideMe = true
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Test Sub-Master"
        tableView.register(DemoCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideMe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if hideMe {
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
        hideMe = false
        CoreServices.shared.setActiveDetail(passedEnum)
        delegate?.showDetailView()
    }
}
