//
//  ViewProtocols.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

protocol ProgramBuildable {
    func createControls()
}

protocol NetworkAvailabilityWatcher {
    func networkStatusChangedTo(_ status: NetworkStatus)
}


enum NetworkStatus {
    case unavailable
    case wifi
    case available
}
