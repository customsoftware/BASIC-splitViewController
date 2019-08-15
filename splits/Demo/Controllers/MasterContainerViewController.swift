//
//  MasterContainerViewController.swift
//  Demo
//
//  Created by Administrator on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class MasterContainerViewController: UIViewController {
    var lastMode: ListMode?
    
    lazy var masterView: MasterViewController? = {
        return storyboard?.instantiateViewController(withIdentifier: "master") as? MasterViewController
    }()
    
    lazy var altMasterVC: AltMaster? = {
        return storyboard?.instantiateViewController(withIdentifier: "sub") as? AltMaster
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

@objc
fileprivate extension MasterContainerViewController {
    func revertToMaster() {
        CoreServices.shared.setCurrentMode(.master)
    }
    
    func showSubMaster() {
        CoreServices.shared.setCurrentMode(.detail)
    }

    func insertNewObject(_ sender: Any) {
        let event = Event(timeStamp: Date())
        CoreServices.shared.addEvent(event)
    }
}

// MARK: - Child view management code
fileprivate extension MasterContainerViewController {
    func setForMaster() {
        guard let masterTable = masterView else { return }
      
        navigationItem.title = "Master View"
        let jump = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showSubMaster))
        navigationItem.leftBarButtonItem = jump
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        removeChildViewControllers()
        addNewViewController(masterTable)
        showNewView(masterTable.view)
        lastMode = .master
    }
    
    func setForSub() {
        guard let subTable = altMasterVC else { return }
     
        navigationItem.title = "Sub View"
        navigationItem.rightBarButtonItem = nil
        let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(revertToMaster))
        navigationItem.leftBarButtonItem = back
        
        removeChildViewControllers()
        addNewViewController(subTable)
        showNewView(subTable.view)
        lastMode = .detail
    }
    
    func addNewViewController(_ newVC: UIViewController) {
        if let newView = newVC.view {
            view.addSubview(newView)
            setConstraints(for: newView)
            newView.alpha = 0
        }
        
        newVC.willMove(toParent: self)
        addChild(newVC)
        if let tableVC = newVC as? UITableViewController {
            tableVC.tableView.reloadData()
        }
    }
    
    func hideOtherChild(_ mode: ListMode) {
        var dissappearingView: UIView?
        switch mode {
        case .detail:
            // If the master is there, hide it
            guard let master = getMaster() else { return }
            dissappearingView = master.view
        case .master:
            // If the sub is there, hide it
            guard let sub = getSub() else { return }
            dissappearingView = sub.view
        }
        
        if let theViewToHide = dissappearingView {
            UIView.animate(withDuration: 0.5) {
                theViewToHide.alpha = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showNewView(_ view: UIView) {
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func getMaster() -> MasterViewController? {
        var retValue: MasterViewController?
        children.forEach({
            if let vc = $0 as? MasterViewController {
                retValue = vc
            }
        })
        return retValue
    }
    
    func getSub() -> AltMaster? {
        var retValue: AltMaster?
        children.forEach({
            if let vc = $0 as? AltMaster {
                retValue = vc
            }
        })
        return retValue
    }
    
    func removeChildViewControllers() {
        children.forEach({
            guard $0 is UITableViewController else { return }
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        return
    }
    
    // If you don't set constraints, when you load the child view controllers, they could show up anywhwere in the detail view. This forces them to be in the right place.
    func setConstraints(for newView: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0),
            newView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) ])
    }
    
    func shouldUpdateMode(_ mode: ListMode) -> Bool {
        var retValue = true
        guard let lastMode = lastMode else { return retValue }
        retValue = false
        switch lastMode {
        case .detail:
            retValue = mode != .detail
        case .master:
            retValue = mode != .master
        }
        return retValue
    }
}

extension MasterContainerViewController: Responder {
    func stateChanged() {
        guard let mode = CoreServices.shared.activeMode,
            shouldUpdateMode(mode) else { return }
        
        hideOtherChild(mode)
        switch mode {
        case .master:
            setForMaster()
        case .detail:
            setForSub()
        }
    }
}
