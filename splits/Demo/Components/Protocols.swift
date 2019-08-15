//
//  Protocols.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol Responder: UIViewController {
    func stateChanged()
}

protocol ShowAllDetails: UIViewController {
    func showDetailView()
}
