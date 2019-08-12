//
//  TestWindows.swift
//  splits
//
//  Created by Kenneth Cluff on 8/9/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

// Your real content replaces these view controllers
class TestVCOne: DetailViewBase {
    override func loadView() {
        super.loadView()
        guard let activeDetail = CoreServices.shared.activeDetail else { return }
        view.backgroundColor = activeDetail.detailColor
        navigationItem.title = activeDetail.detailText
    }
}

class TestVCTwo: DetailViewBase {
    override func loadView() {
        super.loadView()
        guard let activeDetail = CoreServices.shared.activeDetail else { return }
        view.backgroundColor = activeDetail.detailColor
        navigationItem.title = activeDetail.detailText
    }
}

class TestVCThree: DetailViewBase {
    override func loadView() {
        super.loadView()
        guard let activeDetail = CoreServices.shared.activeDetail else { return }
        view.backgroundColor = activeDetail.detailColor
        navigationItem.title = activeDetail.detailText
    }
}

class DetailViewBase: UIViewController { }
