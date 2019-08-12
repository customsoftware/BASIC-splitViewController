//
//  Managers.swift
//  splits
//
//  Created by Kenneth Cluff on 8/7/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import Foundation

class CoreServices {
    static let shared = CoreServices()
    
    private var _delegates = [Responder?]()
    private(set) var activeDetail: TestDetails?
    private(set) var activeMode: ListMode? = .master
    
    func registerDelegate(_ newDelegate: Responder?) {
        _delegates.append(newDelegate)
    }
    
    private func notifyDelegates() {
        _delegates.forEach({
            $0?.stateChanged()
        })
    }
    
    func setCurrentMode(_ newMode: ListMode) {
        activeMode = newMode
        activeDetail = nil
        notifyDelegates()
    }
    
    func setActiveDetail(_ newDetail: TestDetails?) {
        activeDetail = newDetail
        notifyDelegates()
    }
}
