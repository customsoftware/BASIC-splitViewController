//
//  DetailViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ProgramBuildable {
    func createControls() {
        
    }
    
    var visibleViewController: UIViewController?
    
    var controllingEnum: TestDetails? {
        didSet {
            guard let controllingEnum = controllingEnum else { return }
            
            if let navC = navigationController,
                navC.viewControllers.count > 1 {
                
                navC.popViewController(animated: false)
                
            }
            
            switch controllingEnum {
            case .exampleOne:
                visibleViewController = TestVCOne()
                
            case .exampleTwo:
                visibleViewController = TestVCTwo()
                
            case .exampleThree:
                visibleViewController = TestVCThree()
                
            }
            
            if let navC = navigationController,
                let vc = visibleViewController {
                navC.pushViewController(vc, animated: false)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        navigationItem.title = "Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass == .compact {
            print("We're compact")
            // Show master view
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            print("were normal")
            splitViewController?.preferredDisplayMode = .automatic
        }
    }
}
