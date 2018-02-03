//
//  PDMQueue.swift
//  PDMUtils_iOS
//
//  Created by Pedro L. Diaz Montilla on 3/2/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

class PDMQueue {
    
    /// Executes a task in the main queue with a delay of a certain number of seconds
    ///
    /// - Parameters:
    ///   - delay: Number of seconds to delay the task execution
    ///   - closure: The task to be executed
    class func execAfter(delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    /// Executes a task in the main queue
    ///
    /// - Parameter closure: The task to be executed
    class func execInMainThread(closure: @escaping () -> ()) {
        DispatchQueue.main.async { closure() }
    }

}
