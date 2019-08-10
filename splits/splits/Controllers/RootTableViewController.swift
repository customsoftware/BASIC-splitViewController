//
//  RootTableViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

enum TestDetails: CaseIterable {
    case exampleOne
    case exampleTwo
    case exampleThree
}

enum TestSegues: String {
    case testSegueID
}

class RootTableViewController: UITableViewController, ProgramBuildable {
    let cellID = "DemoCellID"
    let segueID = "testSegueID"
    
    func createControls() {
        
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Test Master"
        tableView.register(DemoCell.self, forCellReuseIdentifier: cellID)
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
        guard let split = splitViewController as? HomeSplitViewController else { return }
        split.showDetailViewController(split.detailNav, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
