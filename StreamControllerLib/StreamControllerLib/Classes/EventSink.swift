//
//  StreamSink.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class EventSink<D> {

    private let stream: Stream<D>
    
    internal init(stream: Stream<D>) {
        self.stream = stream
    }
    
    public func add(event: D) {
        stream.listernerCallList.forEach { listener in
            listener?(event)
        }
    }
    
    public func addError(object: Any) {
        stream.catchErrorCallList.forEach { listener in
            listener?(object)
        }
    }
    
    public func close() {
        
    }
    
}
