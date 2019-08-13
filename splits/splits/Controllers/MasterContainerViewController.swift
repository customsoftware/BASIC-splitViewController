//
//  MasterContainerViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/13/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class MasterContainerViewController: UIViewController {

    var lastMode: ListMode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.delegate = self
        
        setForMaster()
    }
    
    @objc
    func revertToMaster() {
        CoreServices.shared.setCurrentMode(.master)
    }
    
    func setForMaster() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Master View"
        
        guard let masterTable = storyboard?.instantiateViewController(withIdentifier: "master") as? RootTableViewController else { return }
        if let newView = masterTable.view {
            view.addSubview(newView)
            setConstraints(for: newView)
            newView.alpha = 0
        }
        
        masterTable.willMove(toParent: self)
        addChild(masterTable)
        masterTable.tableView.reloadData()
        showNewView(masterTable.view)
    }
    
    func setForSub() {
        let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(revertToMaster))
        navigationItem.leftBarButtonItem = back
        navigationItem.title = "Sub View"
        
        guard let subTable = storyboard?.instantiateViewController(withIdentifier: "sub") as? SubMasterTableViewController else { return }
        if let newView = subTable.view {
            view.addSubview(newView)
            setConstraints(for: newView)
            newView.alpha = 0
        }
        
        subTable.willMove(toParent: self)
        addChild(subTable)
        subTable.tableView.reloadData()
        showNewView(subTable.view)
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
    
    func getMaster() -> RootTableViewController? {
        var retValue: RootTableViewController?
        children.forEach({
            if let vc = $0 as? RootTableViewController {
                retValue = vc
            }
        })
        return retValue
    }
    
    func getSub() -> SubMasterTableViewController? {
        var retValue: SubMasterTableViewController?
        children.forEach({
            if let vc = $0 as? SubMasterTableViewController {
                retValue = vc
            }
        })
        return retValue
    }
}

extension MasterContainerViewController: Responder {
    func stateChanged() {
        guard let mode = CoreServices.shared.activeMode else { return }
        var update = false
        if lastMode == nil {
            update = true
        } else if let last = lastMode {
            switch last {
            case .detail:
                update = mode != .detail
            case .master:
                update = mode != .master
            }
        }
        
        if update {
            hideOtherChild(mode)
            switch mode {
            case .master:
                setForMaster()
            case .detail:
                setForSub()
            }
        }
        lastMode = mode
    }
}

fileprivate extension MasterContainerViewController {
    // If you don't set constraints, when you load the child view controllers, they could show up anywhwere in the detail view. This forces them to be in the right place.
    func setConstraints(for newView: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0),
            newView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) ])
    }
}


extension MasterContainerViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller. The activeDetail property will be nil only if we're not showing content.
        return CoreServices.shared.activeDetail == nil
    }
}
