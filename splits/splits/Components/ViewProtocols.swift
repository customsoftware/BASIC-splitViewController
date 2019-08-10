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

protocol Responder {
    func stateChanged()
    //    func updateState(with type: StateTypes, and value: Any)
}

enum StateTypes {
    case detailChanged
}

enum NetworkStatus {
    case unavailable
    case wifi
    case available
}

struct DetailFactory {
    static func build(for anEnum: TestDetails) -> DetailViewBase {
        let retVC: DetailViewBase
        switch anEnum {
        case .exampleOne:
            retVC = TestVCOne()
        case .exampleTwo:
            retVC = TestVCTwo()
        case .exampleThree:
            retVC = TestVCThree()
        }
        return retVC
    }
}
