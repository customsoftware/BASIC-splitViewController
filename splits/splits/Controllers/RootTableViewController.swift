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

class RootTableViewController: UITableViewController {
    let cellID = "DemoCellID"
   
    var keepAliveDelegate: ProgramBuildable?
    
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
    
//        guard let detail = keepAliveDelegate as? DetailViewController,
//            let detailNav = detail.navigationController else { return }
//        
//        splitViewController?.showDetailViewController(detailNav, sender: nil)
    }
}

fileprivate extension RootTableViewController {
    func pushToSubTable() {
        CoreServices.shared.setActiveDetail(nil)
        let newVC = BranchTableViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
}
