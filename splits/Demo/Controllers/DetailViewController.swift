//
//  DetailViewController.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        guard let detail = CoreServices.shared.activeEvent?.timeStamp,
            let label = detailDescriptionLabel else { return }
        label.text = detail.description
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
}

extension DetailViewController: Responder {
    func stateChanged() {
        configureView()
    }
}
