//
//  PersistentStreamController.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 17/12/2020.
//

import Foundation

final public class PersistentStreamController<T>: StreamController<T> {
    
    private (set) var value: T?
    
    override init(stream: Stream<T>) {
        super.init(stream: stream)
    }
    

    
}
