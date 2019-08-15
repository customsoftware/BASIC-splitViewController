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
        return storyboard?.instantiateViewController(withIdentifier: "master") as? MasterViewController
    }()
    
    lazy var altMasterVC: AltMaster? = {
        return storyboard?.instantiateViewController(withIdentifier: "sub") as? AltMaster
    }()
    
    func getMasterView() -> UIViewController? {
        guard let mode = CoreServices.shared.activeMode else { return nil }
        switch mode {
        case .detail:
            return altMasterVC
        case .master:
            return masterView
        }
    }
}
