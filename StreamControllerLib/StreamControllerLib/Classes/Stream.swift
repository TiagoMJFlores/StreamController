//
//  Stream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class Stream<T>  {
   
    private let streamListenType: StreamListenType
    
    required init(streamListenState: StreamListenType = .singleListener) {
        self.streamListenType = streamListenState
    }
    
 
    typealias ListenCallbackType = ((T) -> Void)?
    typealias CatchErrorCallbackType = ((Any) -> Void)?
    

    var eventReceivedTransformHelper: ((T) -> Void)?
    
    var listernerCallList: [ListenCallbackType] = []
    var catchErrorCallList: [CatchErrorCallbackType] = []
   
    @discardableResult
    public func listen(received callback: @escaping (T) -> Void) -> Self {
        
        switch streamListenType {
        case .singleListener:
            listernerCallList = [callback]
            break
        case .multipleListener:
            listernerCallList.append(callback)
            break
        }
        
        return self
    }
    
    @discardableResult
    public func catchError(received callback: @escaping (Any) -> Void) -> Self {
        
        switch streamListenType {
        case .singleListener:
            catchErrorCallList = [callback]
            break
        case .multipleListener:
            catchErrorCallList.append(callback)
            break
        }
        return self
    }
    
    func close() {
        listernerCallList = []
        catchErrorCallList = []
    }
    
    
    public func transform<U>(streamTransformer:  StreamTransformer<T,U>) -> Stream<U>  {
   
        eventReceivedTransformHelper = { event in
            streamTransformer.handlers(event, streamTransformer.streamController.sink)
        }
        return  streamTransformer.streamController.stream
    }
    
}
