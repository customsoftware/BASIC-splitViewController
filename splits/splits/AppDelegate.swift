//
//  AppDelegate.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpSplitView()
        return true
    }

    private func setUpSplitView() {
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? RootTableViewController,
            let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = rightNavController.topViewController as? DetailViewController
            else { fatalError() }
        
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.preferredDisplayMode = .allVisible
        
        // The ONLY reason for this delegate is to keep a pointer to the detail view controller. We want the detail to stay alive. This does it.
        masterViewController.detailDelegate = detailViewController
   
        //  Register the delegates to the CoreServices so they can respond to state changes.
        CoreServices.shared.registerDelegate(detailViewController)
        CoreServices.shared.registerDelegate(masterViewController)
       
        //  Now, update the state to get started with the app. If you don't do this, it will start in the master view when on an iPhone with compact horizontal display.
        CoreServices.shared.setActiveDetail(.exampleOne)
    }
}

