//
//  MasterViewController.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CoreServices.shared.registerDelegate(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        defer { super.viewWillAppear(animated) }
        guard let split = parent?.splitViewController else { return }
        clearsSelectionOnViewWillAppear = split.isCollapsed
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreServices.shared.eventList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = CoreServices.shared.eventList[indexPath.row]
        cell.textLabel!.text = object.timeStamp.description
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = CoreServices.shared.eventList[indexPath.row]
        CoreServices.shared.setActiveDetail(event)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            CoreServices.shared.removeEventAt(indexPath.row)
        case .insert, .none:()
        @unknown default:
            fatalError("Boom baby! - tableview")
        }
    }
}

extension MasterViewController: Responder {
    func stateChanged() {
        tableView.reloadData()
        
        guard let split = splitViewController,
            let detail = CoreServices.shared.detailView,
            let detailNav = detail.navigationController,
            let _ = CoreServices.shared.activeEvent else { return }
        
        split.showDetailViewController(detailNav, sender: nil)
    }
}
