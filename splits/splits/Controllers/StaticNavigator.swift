//
//  StaticNavigator.swift
//  splits
//
//  Created by Kenneth Cluff on 8/10/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class StaticNavigator: UINavigationController {
    static let shared = UINavigationController(rootViewController: DetailViewController())
}
