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
            setConstraints(for: newView)
        }
    }
}

fileprivate extension DetailViewController {
    // If you don't set constraints, when you load the child view controllers, they could show up anywhwere in the detail view. This forces them to be in the right place.
    func setConstraints(for newView: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0),
            newView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) ])
    }
    
    func drainChildren() {
        children.forEach({
            // This so you remove only the variable content
            guard $0 is DetailViewBase else { return }
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        return
    }
    
    func getTitle(_ anEnum: TestDetails?) -> String {
        guard let anEnum = anEnum else { return "Default" }
        return anEnum.detailText
    }
}
