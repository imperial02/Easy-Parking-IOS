//
//  Async.swift
//  Easy - Parking
//
//  Created by Любчик on 10/27/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import Foundation

var MainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalUserInteractiveQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
}

var GlobalUserInitiatedQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
}

var GlobalUtilityQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
}

final class Async {
    
    static func mainQueue(_ block: @escaping () -> Void ) {
        MainQueue.async {
            block()
        }
    }
    
    static func globalQueue(_ block: @escaping () -> Void, priority: DispatchQoS.QoSClass = .userInitiated) {
        DispatchQueue.global(qos: priority).async {
            block()
        }
    }
    
    static func delayExecutionBy(_ time: Double, completion: @escaping () -> Void) {
        MainQueue.asyncAfter(deadline: .now() + time) {
            completion()
        }
    }
    
}


