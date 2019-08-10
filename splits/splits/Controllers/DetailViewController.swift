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
}

extension DetailViewController: Responder {
    func stateChanged() {
        guard let newState = CoreServices.shared.activeDetail else { return }
        let newVC = DetailFactory.build(for: newState)
        addChild(newVC)
        view.addSubview(newVC.view)
    }
}
