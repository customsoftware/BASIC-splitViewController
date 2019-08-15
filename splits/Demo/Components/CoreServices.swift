//
//  CoreServices.swift
//  Demo
//
//  Created by Kenneth Cluff on 8/15/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class CoreServices {
    static let shared = CoreServices()
    
    private var _delegates = [Responder?]()
    private(set) var activeEvent: Event?
    private(set) var eventList = [Event]()
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
    
    func addEvent(_ event: Event) {
        eventList.append(event)
        activeEvent = event
        notifyDelegates()
    }
    
    func removeEventAt(_ row: Int) {
        eventList.remove(at: row)
        activeEvent = nil
        notifyDelegates()
    }
    
    func setActiveDetail(_ newEvent: Event?) {
        activeEvent = newEvent
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
        activeEvent = nil
    }
}
