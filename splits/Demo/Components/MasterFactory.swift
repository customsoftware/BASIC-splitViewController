//
//  MasterFactory.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class MasterFactory {
    static let shared = MasterFactory()
    
    lazy var masterView: MasterViewController? = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let master = storyboard.instantiateViewController(withIdentifier: "master") as? MasterViewController else { return nil }
        return master
    }()
    
    lazy var altMasterVC: AltMaster? = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let sub = storyboard.instantiateViewController(withIdentifier: "sub") as? AltMaster else { return nil }
        return sub
    }()
    
    func getMasterView(for mode: ListMode) -> UIViewController? {
        switch mode {
        case .detail:
            return altMasterVC
        case .master:
            return masterView
        }
    }
}
