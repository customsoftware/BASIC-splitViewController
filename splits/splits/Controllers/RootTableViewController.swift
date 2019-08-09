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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let segueID = segue.identifier,
//            let theEnum = sender as? TestDetails,
//            let option = TestSegues(rawValue: segueID) else { return }
//        switch option {
//        case .testSegueID:
//            let newVC = segue.destination as! DetailViewController
//            newVC.controllingEnum = theEnum
//        }
//    }
    
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
        showEnum(passedEnum)
    }
    
    private func showEnum(_ theEnum: TestDetails) {
        if traitCollection.horizontalSizeClass == .compact {
            print("We're compact")
            let newVC = DetailViewController()
            newVC.controllingEnum = theEnum
            let newNavC = UINavigationController(rootViewController: newVC)
            splitViewController?.showDetailViewController(newNavC, sender: nil)
            newVC.refreshView()
        } else {
            print("were normal")
            guard let detailNav = splitViewController?.viewControllers.last as? UINavigationController,
                let detailView = detailNav.viewControllers.first as? DetailViewController else { return }
            detailView.controllingEnum = theEnum
        }
    }
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
