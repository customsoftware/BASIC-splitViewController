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

protocol ShowAllDetails: UIViewController {
    func showDetailView()
    func pushToSubTable()
}



class RootTableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var showDelegate: ShowAllDetails?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        switch passedEnum {
        case .exampleOne, .exampleTwo:
            CoreServices.shared.setActiveDetail(passedEnum)
            showDelegate?.showDetailView()
        case .exampleThree:
            showDelegate?.pushToSubTable()
        }
    }
}


class BranchTableViewDelegate: NSObject, UITableViewDelegate {
    weak var showDelegate: ShowAllDetails?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        CoreServices.shared.setActiveDetail(passedEnum)
        showDelegate?.showDetailView()
    }
}
