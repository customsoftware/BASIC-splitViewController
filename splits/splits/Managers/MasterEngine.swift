//
//  MasterEngine.swift
//  splits
//
//  Created by Administrator on 8/12/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class MasterTableViewEngine: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let cellID = "MasterCellID"
    
    weak var showDelegate: ShowAllDetails?
    
    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MasterList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoMasterCell
        cell.controllingEnum = MasterList.allCases[indexPath.row]
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        switch passedEnum {
        case .exampleOne, .exampleTwo:
            CoreServices.shared.setActiveDetail(passedEnum)
            showDelegate?.showDetailView()
        case .exampleThree:
            CoreServices.shared.setCurrentMode(.detail)
        }
    }
}
