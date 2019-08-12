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
            retColor = .blue
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

class MasterTableViewEngine: NSObject, UITableViewDelegate, UITableViewDataSource {
    let cellID = "MasterCellID"
    
    weak var showDelegate: ShowAllDetails?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MasterList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoMasterCell
        cell.controllingEnum = MasterList.allCases[indexPath.row]
        return cell
    }
    
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

class SubTableViewEngine: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var showDelegate: ShowAllDetails?
    let cellID = "DemoCellID"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestDetails.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoSubCell
        cell.controllingEnum = TestDetails.allCases[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        CoreServices.shared.setActiveDetail(passedEnum)
        showDelegate?.showDetailView()
    }
}
