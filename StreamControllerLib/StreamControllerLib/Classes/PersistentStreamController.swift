//
//  PersistentStreamController.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 17/12/2020.
//

import Foundation

final public class PersistentStreamController<T>: StreamController<T> {
    
    public private (set) var value: T? = nil
    
    public init() {
        super.init(streamListenType: .multipleListener)
        stream.listen { [weak self] receivedValue in
            self?.value = receivedValue
        }
    }
    
}
