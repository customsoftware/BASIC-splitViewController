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

    @objc
    func insertNewObject(_ sender: Any) {
        let newEvent = Event(timeStamp: Date())
        CoreServices.shared.addEvent(newEvent)
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
        if editingStyle == .delete {
            CoreServices.shared.removeEventAt(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
