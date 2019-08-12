//
//  DetailFactory.swift
//  splits
//
//  Created by Administrator on 8/12/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import Foundation

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
