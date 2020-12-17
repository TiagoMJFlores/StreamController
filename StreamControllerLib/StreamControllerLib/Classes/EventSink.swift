//
//  StreamSink.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class EventSink<D> {

    private let stream: Stream<D>
    private var isClosed: Bool
    
    internal init(stream: Stream<D>) {
        self.stream = stream
        self.isClosed = false
    }
    
    public func add(_ event: D) {
        
        guard !isClosed else { return }
        stream.listernerCallList.forEach { listener in
            listener?(event)
        }
    }
    
    public func addError(_ error: Any) {
        
        guard !isClosed else { return }
        stream.catchErrorCallList.forEach { listener in
            listener?(error)
        }
    }
    
    public func close() {
        stream.close()
        isClosed = true
    }
    
}
