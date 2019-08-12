//
//  HomeSplitViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class HomeSplitViewController: UISplitViewController {
    lazy var detail: DetailViewController = {
        let retValue = detailNav.viewControllers.last as! DetailViewController
        return retValue
    }()
    let detailNav = StaticNavigator.shared
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // If we have just one view controller and that controller is master...
        // trouble-shooting data dump
        print("Pre-Horizontal size compact? \(traitCollection.horizontalSizeClass == .compact)")
        print("Pre-Vertical size compact? \(traitCollection.verticalSizeClass == .compact)")
        print("Pre-Split View view controllers: \(self.viewControllers.count)")
        
        if self.viewControllers.count > 2 {
            fatalError("Pre-To many view controllers.")
        }
        
        if self.viewControllers.count > 0,
            self.viewControllers.count <= 2,
            let firstNav = self.viewControllers.first as? UINavigationController,
            let masterView = firstNav.viewControllers.first as? RootTableViewController {
            print("Pre-Master view class: RootViewController")
        }
        
        if self.viewControllers.count == 2,
            let lastNav = self.viewControllers.last as? UINavigationController,
            let detailView = lastNav.viewControllers.last {
            
            if  detailView is DetailViewController {
                print("Pre-Detail view class: DetailViewController")
            } else {
                print("Pre-??")
            }
        }
        
//        guard newCollection.horizontalSizeClass == .regular,
//            newCollection.verticalSizeClass == .compact,
//            viewControllers.count == 1,
//            let navC = viewControllers.first as? UINavigationController,
//            navC.viewControllers.count > 1 else {
//            return
//            }
        
        // Move the last view controller into the detail position
//        if let detail = navC.viewControllers.last as? UINavigationController {
//            detail.willMove(toParent: self)
//            detail.view.removeFromSuperview()
//            detail.removeFromParent()
//        }
//        print(navC.viewControllers)
    }
}

fileprivate extension HomeSplitViewController {
    func primaryNavigation(_ split: UISplitViewController) -> UINavigationController {
        guard let nav = split.viewControllers.first as? UINavigationController else {
            fatalError("The primary is always a nav controller")
        }
        
        return nav
    }
    
    func activeDetailView(_ split: UISplitViewController) -> DetailViewBase? {
        var retValue: DetailViewBase?
        
        guard let navigation = split.viewControllers.last as? UINavigationController,
            let detail = navigation.topViewController as? DetailViewController,
            navigation.viewControllers.count > 0,
            let activeDetail = detail.children.last as? DetailViewBase? else { return retValue }
        
        retValue = activeDetail
        
        return retValue
    }
}

//
//extension HomeSplitViewController: UISplitViewControllerDelegate {
//    func splitViewController(_ splitViewController: UISplitViewController,
//                             collapseSecondary secondaryViewController:UIViewController,
//                             onto primaryViewController:UIViewController) -> Bool {
//
//        var retValue = false
//        let primaryNav = primaryNavigation(splitViewController)
//        if let secondaryNav = secondaryViewController as? UINavigationController {
//
//            let activeDetail = activeDetailView(splitViewController)
//            print("whoaH")
//
//        } else {
//            retValue = true
//        }
//
//        return retValue
//    }
//}
