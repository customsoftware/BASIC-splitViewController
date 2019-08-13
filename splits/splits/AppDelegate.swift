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
        initialDataLoad()
        return true
    }
}

fileprivate extension AppDelegate {
    func setUpSplitView() {
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? RootTableViewController,
            let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = rightNavController.topViewController as? DetailViewController
            else { fatalError("The splitViewController failed to build itself.... Boom!") }
        
        splitViewController.preferredDisplayMode = .allVisible
        configureDetailViewLeftBarbutton(detailViewController, in: splitViewController)
        CoreServices.shared.rememberDetailViewController(detailViewController)
        registerToCoreServices(detail: detailViewController, andMaster: masterViewController)
    }
    
    func registerToCoreServices(detail detailViewController: Responder, andMaster masterViewController: Responder) {
        CoreServices.shared.registerDelegate(detailViewController)
        CoreServices.shared.registerDelegate(masterViewController)
    }
    
    func configureDetailViewLeftBarbutton(_ detailViewController: UIViewController, in splitViewController: UISplitViewController) {
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
    
    func initialDataLoad() {
        //  Now, update the state to get started with the app. If you don't do this, it will start in the master view when on an iPhone with compact horizontal display.
        CoreServices.shared.setActiveDetail(.exampleOne)
    }
}
