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
    private(set) var detailNav = UINavigationController()
    
    func configure() {
        masterNav = UINavigationController(rootViewController: master)
        detailNav = UINavigationController(rootViewController: detail)
        
        detail.navigationItem.leftItemsSupplementBackButton = true
        detail.navigationItem.leftBarButtonItem = displayModeButtonItem
        
        viewControllers = [masterNav, detailNav]
        delegate = self
        preferredDisplayMode = .allVisible
        CoreServices.shared.registerDelegate(detail)
    }
}

extension HomeSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController:UIViewController,
                             onto primaryViewController:UIViewController) -> Bool {

        var retValue = true
        
        if let navC = secondaryViewController as? UINavigationController,
            let vc = navC.visibleViewController,
            vc.self is DetailViewBase {

            retValue = false
        } else if splitViewController.viewControllers.count == 1 {
            retValue = true
        }

        return retValue
    }
}
