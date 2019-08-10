//
//  HomeSplitViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class HomeSplitViewController: UISplitViewController {
    
//    private var master: RootTableViewController!
//    private(set) var detail: DetailViewController!
//    private var masterNav: UINavigationController!
//    private(set) var detailNav: UINavigationController!
    
//    func configure() {
//        guard let mNav = viewControllers.first as? UINavigationController?,
//            let mVC = mNav?.topViewController as? RootTableViewController?,
//            let dNav = viewControllers.last as? UINavigationController?,
//            let dVC = dNav?.topViewController as? DetailViewController? else { return }
//
//        master = mVC
//        detail = dVC
//        masterNav = mNav
//        detailNav = dNav
//
//        master?.keepAliveDelegate = detail
////        masterNav = UINavigationController(rootViewController: master)
////        detailNav = UINavigationController(rootViewController: detail)
////
////        master.keepAliveDelegate = detail
//
//        detail?.navigationItem.leftItemsSupplementBackButton = true
//        detail?.navigationItem.leftBarButtonItem = displayModeButtonItem
//
////        viewControllers = [masterNav, detailNav]
////        delegate = self
//        preferredDisplayMode = .allVisible
//        CoreServices.shared.registerDelegate(detail)
//    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // If we have just one view controller and that controller is master...
        guard newCollection.horizontalSizeClass == .regular,
            newCollection.verticalSizeClass == .compact,
            viewControllers.count == 1,
            let navC = viewControllers.first as? UINavigationController,
            navC.viewControllers.count > 1 else {
            return
            }
        
        // Move the last view controller into the detail position
//        if let detail = navC.viewControllers.last as? UINavigationController {
//            detail.willMove(toParent: self)
//            detail.view.removeFromSuperview()
//            detail.removeFromParent()
//        }
//        print(navC.viewControllers)
    }
}
//
//extension HomeSplitViewController: UISplitViewControllerDelegate {
//    func splitViewController(_ splitViewController: UISplitViewController,
//                             collapseSecondary secondaryViewController:UIViewController,
//                             onto primaryViewController:UIViewController) -> Bool {
//
//        var retValue = true
//
//        if let navC = secondaryViewController as? UINavigationController,
//            let vc = navC.visibleViewController,
//            vc.self is DetailViewBase {
//
//            retValue = false
//        } else if splitViewController.viewControllers.count == 1 {
//            retValue = true
//        }
//
//        return retValue
//    }
//}
