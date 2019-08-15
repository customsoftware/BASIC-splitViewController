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
    }
}

fileprivate extension MasterContainerViewController {
    @objc
    func revertToMaster() {
        CoreServices.shared.setCurrentMode(.master)
    }
    
    func setForMaster() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Master View"
        
        guard let masterTable = storyboard?.instantiateViewController(withIdentifier: "master") as? RootTableViewController else { return }
        
        removeChildViewControllers()
        addNewViewController(masterTable)
        showNewView(masterTable.view)
    }
    
    func setForSub() {
        let back = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(revertToMaster))
        navigationItem.leftBarButtonItem = back
        navigationItem.title = "Sub View"
        
        guard let subTable = storyboard?.instantiateViewController(withIdentifier: "sub") as? SubMasterTableViewController else { return }
        
        removeChildViewControllers()
        addNewViewController(subTable)
        showNewView(subTable.view)
    }
    
    func addNewViewController(_ newVC: UITableViewController) {
        if let newView = newVC.view {
            view.addSubview(newView)
            setConstraints(for: newView)
            newView.alpha = 0
        }
        
        newVC.willMove(toParent: self)
        addChild(newVC)
        newVC.tableView.reloadData()
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
        guard let mode = CoreServices.shared.activeMode else { return }
        if shouldUpdateMode(mode) {
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

extension MasterContainerViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller. The activeDetail property will be nil only if we're not showing content.
        return CoreServices.shared.activeDetail == nil
    }
}
