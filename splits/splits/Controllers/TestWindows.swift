//
//  TestWindows.swift
//  splits
//
//  Created by Kenneth Cluff on 8/9/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class TestVCOne: DetailViewBase {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        navigationItem.title = "Light"
    }
}

class TestVCTwo: DetailViewBase {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .darkGray
        navigationItem.title = "Dark"
    }
}

class TestVCThree: DetailViewBase {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.title = "White"
    }
}

class DetailViewBase: UIViewController { }
