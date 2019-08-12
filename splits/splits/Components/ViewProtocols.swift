//
//  ViewProtocols.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol KeepDetailAlive: UIViewController {}

protocol Responder: UIViewController {
    func stateChanged()
}

protocol ShowAllDetails: UIViewController {
    func showDetailView()
    func pushToSubTable()
}
