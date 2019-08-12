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

protocol Responder: UIViewController {
    func stateChanged()
    //    func updateState(with type: StateTypes, and value: Any)
}

enum SegueOptions: String {
    case pushDetail
    case pushBranch
    case pushAltDetail
}

enum StateTypes {
    case detailChanged
}

enum TestDetails: CaseIterable {
    case exampleOne
    case exampleTwo
    case exampleThree
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
