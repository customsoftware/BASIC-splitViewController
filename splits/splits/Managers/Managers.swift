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
    
    func registerDelegate(_ newDelegate: Responder?) {
        _delegates.append(newDelegate)
    }
    
    private func notifyDelegates() {
        _delegates.forEach({
            $0?.stateChanged()
        })
    }
    
    func setActiveDetail(_ newDetail: TestDetails?) {
        activeDetail = newDetail
        notifyDelegates()
    }
}
