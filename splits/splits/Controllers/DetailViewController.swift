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
            refreshView()
        }
    }
    
    func refreshView() {
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
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        navigationItem.title = "Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
