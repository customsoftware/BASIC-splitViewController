//
//  SubEngine.swift
//  splits
//
//  Created by Administrator on 8/12/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class SubTableViewEngine: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let cellID = "DemoCellID"
    weak var showDelegate: ShowAllDetails?
    
    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestDetails.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DemoSubCell
        cell.controllingEnum = TestDetails.allCases[indexPath.row]
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedEnum = TestDetails.allCases[indexPath.row]
        CoreServices.shared.setActiveDetail(passedEnum)
        showDelegate?.showDetailView()
    }
}
