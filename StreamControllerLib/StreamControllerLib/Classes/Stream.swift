//
//  Stream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class Stream<T> {
    
    required public init() {}
    
    var receivedCallback: ((T) -> Void)?
    
    public func listen(received: @escaping (T) -> Void) {
        self.receivedCallback = received
    }
}
