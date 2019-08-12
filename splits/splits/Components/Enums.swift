//
//  Enums.swift
//  splits
//
//  Created by Administrator on 8/12/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

enum ListMode {
    case master
    case detail
}

enum SegueOptions: String {
    case pushDetail
    case pushBranch
    case pushAltDetail
}

enum StateTypes {
    case detailChanged
}

enum MasterList: CaseIterable {
    case exampleOne
    case exampleTwo
    case subList
    
    var detailColor: UIColor {
        let retColor: UIColor
        switch self {
        case .subList:
            retColor = .yellow
        case .exampleTwo:
            retColor = .green
        case .exampleOne:
            retColor = .red
        }
        return retColor
    }
    
    var textColor: UIColor {
        let retColor: UIColor
        switch self {
        case .subList, .exampleTwo:
            retColor = .black
        case .exampleOne:
            retColor = .white
        }
        return retColor
    }
    
    var detailText: String {
        let retString: String
        switch self {
        case .subList:
            retString = "Sub List"
        case .exampleTwo:
            retString = "Example the second"
        case .exampleOne:
            retString = "One"
        }
        return retString
    }
}

enum TestDetails: CaseIterable {
    case exampleOne
    case exampleTwo
    case exampleThree
    
    var detailColor: UIColor {
        let retColor: UIColor
        switch self {
        case .exampleThree:
            retColor = .white
        case .exampleTwo:
            retColor = .lightGray
        case .exampleOne:
            retColor = .darkGray
        }
        return retColor
    }
    
    var textColor: UIColor {
        let retColor: UIColor
        switch self {
        case .exampleThree, .exampleTwo:
            retColor = .black
        case .exampleOne:
            retColor = .white
        }
        return retColor
    }
    
    var detailText: String {
        let retString: String
        switch self {
        case .exampleThree:
            retString = "Example Three"
        case .exampleTwo:
            retString = "Example the second"
        case .exampleOne:
            retString = "One"
        }
        return retString
    }
}
