//
//  DetailViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        navigationItem.title = "Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateChanged()
    }
    
    deinit {
        print("I'm gone - Detail view")
    }
}

extension DetailViewController: ProgramBuildable {
    func createControls() { }
}

extension DetailViewController: Responder {
    func stateChanged() {
        guard let newState = CoreServices.shared.activeDetail else {
            // There is no state so remove all sub-views
            drailChildren()
            return
        }
        
        if children.count > 0 {
            drailChildren()
        }
        
        let newVC = DetailFactory.build(for: newState)
        newVC.willMove(toParent: self)
        addChild(newVC)
        view.addSubview(newVC.view)
        navigationItem.title = getTitle(newState)
    }
    
    private func drailChildren() {
        children.forEach({
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        return
    }
    
    private func getTitle(_ anEnum: TestDetails) -> String {
        let retValue: String
        switch anEnum {
        case .exampleOne:
            retValue = "Example One"
        case .exampleTwo:
            retValue = "Example the Second"
        case .exampleThree:
            retValue = "Third"
        }
        
        return retValue
    }
    
}
