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


class RootTableViewController: UITableViewController, ProgramBuildable {
    let cellID = "DemoCellID"
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class DemoCell: UITableViewCell {
    var controllingEnum: TestDetails? {
        didSet{
            guard let controllingEnum = controllingEnum else { return }
            switch controllingEnum {
            case .exampleOne:
                textLabel?.text = "The First Choice"
                contentView.backgroundColor = UIColor.lightGray
                
            case .exampleTwo:
                textLabel?.text = "The Second Choice"
                contentView.backgroundColor = UIColor.gray
                textLabel?.textColor = .white
                
            case .exampleThree:
                textLabel?.text = "The Third Choice"
                textLabel?.textColor = .darkGray
            }
        }
    }
}
