//
//  TestWindows.swift
//  splits
//
//  Created by Kenneth Cluff on 8/9/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class TestVCOne: UIViewController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        navigationItem.title = "Light"
    }
}

class TestVCTwo: UIViewController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .darkGray
        navigationItem.title = "Dark"
    }
}

class TestVCThree: UIViewController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.title = "White"
    }
}

