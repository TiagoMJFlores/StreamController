//
//  StreamTransformer.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 22/12/2020.
//

import Foundation


public struct StreamTransformer<T, S>  {
    
    var handlers: ( (_ data: T, _ sink: EventSink<S>) -> Void)
    
    private (set) var streamController: StreamController<S>
 
    init( streamController: StreamController<S>, handlers:  @escaping ( (_ data: T, _ sink: EventSink<S>) -> Void)) {
        self.streamController = streamController
        self.handlers = handlers
    }
    
    public static func fromHandlers(handlers: @escaping (_ data: T, _ sink: EventSink<S>) -> Void) -> StreamTransformer  {
    
        let streamController =  StreamController<
    S>(streamListenType: .multipleListener)
        let streamTransformer = StreamTransformer(streamController: streamController, handlers: handlers)
        return streamTransformer
    }
}
