//
//  HomeSplitViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class HomeSplitViewController: UISplitViewController {
    
    private let master = RootTableViewController()
    private let detail = DetailViewController()
    private var masterNav = UINavigationController()
    
    func configure() {
        masterNav = UINavigationController(rootViewController: master)
        let detailNav = UINavigationController(rootViewController: detail)
        viewControllers = [masterNav, detailNav]
        delegate = self
        preferredDisplayMode = .allVisible
        if let nc = viewControllers.last as? UINavigationController {
            nc.topViewController?.navigationItem.leftBarButtonItem = displayModeButtonItem
        }
    }
    
    
}

extension HomeSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController,
            let _ = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        return true
    }
}
