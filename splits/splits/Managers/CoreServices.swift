//
//  CoreServices.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class CoreServices {
    static let shared = CoreServices()
    
    private var _delegates = [Responder?]()
    private(set) var activeDetail: TestDetails?
    private(set) var activeMode: ListMode? = .master
    private(set) var detailView: UIViewController?
    
    func registerDelegate(_ newDelegate: Responder?) {
        _delegates.append(newDelegate)
    }
    
    func rememberDetailViewController(_ detail: UIViewController) {
        detailView = detail
    }
    
    func setCurrentMode(_ newMode: ListMode) {
        activeMode = newMode
        removeDetailContent()
        notifyDelegates()
    }
    
    func setActiveDetail(_ newDetail: TestDetails?) {
        activeDetail = newDetail
        notifyDelegates()
    }
}

fileprivate extension CoreServices {
    func notifyDelegates() {
        _delegates.forEach({
            $0?.stateChanged()
        })
    }
    
    func removeDetailContent() {
        activeDetail = nil
    }
}
