//
//  DetailViewController.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var state: TestDetails?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        navigationItem.title = "Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if statesHaveChanged() {
            stateChanged()
        }
    }
    
    private func statesHaveChanged() -> Bool {
        guard let state = state,
            let activeState = CoreServices.shared.activeDetail else { return true }
        var retValue = false
        switch state {
        case .exampleOne:
            retValue = activeState == .exampleOne
        case .exampleTwo:
            retValue = activeState == .exampleTwo
        case .exampleThree:
            retValue = activeState == .exampleThree
        }
        return retValue
    }
}

extension DetailViewController: ProgramBuildable {
    func createControls() { }
}

extension DetailViewController: KeepDetailAlive { }

extension DetailViewController: Responder {
    
    func stateChanged() {
        defer {
            navigationItem.title = getTitle(CoreServices.shared.activeDetail)
            state = CoreServices.shared.activeDetail
            view.layoutIfNeeded()
        }
        guard let newState = CoreServices.shared.activeDetail else {
            // There is no state so remove all sub-views
            drainChildren()
            return
        }
        
        drainChildren()
        
        let newVC = DetailFactory.build(for: newState)
        if let newView = newVC.view {
            newVC.willMove(toParent: self)
            addChild(newVC)
            view.addSubview(newView)
            // Set constraints to have the new view fill the available space
            setConstraints(for: newView)
        }
    }
    
    private func setConstraints(for newView: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0),
            newView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) ])
    }
    
    private func drainChildren() {
        children.forEach({
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        return
    }
    
    private func getTitle(_ anEnum: TestDetails?) -> String {
        guard let anEnum = anEnum else { return "Default" }
        return anEnum.detailText
    }
}
