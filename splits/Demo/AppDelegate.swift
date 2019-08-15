//
//  AppDelegate.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpSplitView()
        initialDataLoad()
        return true
    }
}

fileprivate extension AppDelegate {
    func setUpSplitView() {
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? MasterContainerViewController,
            let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = rightNavController.topViewController as? DetailViewController
            else { fatalError("The splitViewController failed to build itself.... Boom!") }
        
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        configureDetailViewLeftBarbutton(detailViewController, in: splitViewController)
        CoreServices.shared.rememberDetailViewController(detailViewController)
        registerViewControllersToCoreServices(detail: detailViewController, andMaster: masterViewController)
    }
    
    func registerViewControllersToCoreServices(detail detailViewController: Responder, andMaster masterViewController: Responder) {
        CoreServices.shared.registerDelegate(detailViewController)
        CoreServices.shared.registerDelegate(masterViewController)
    }
    
    func configureDetailViewLeftBarbutton(_ detailViewController: UIViewController, in splitViewController: UISplitViewController) {
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
    
    func initialDataLoad() {
        //  Now, update the state to get started with the app. If you don't do this, it will start in the master view when on an iPhone with compact horizontal display.
        CoreServices.shared.setActiveDetail(nil)
        CoreServices.shared.setCurrentMode(.master)
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Returning true prevents the default of showing the secondary
        // view controller. The activeDetail property will be nil only if we're not showing content.
        return CoreServices.shared.activeEvent == nil
    }
}
