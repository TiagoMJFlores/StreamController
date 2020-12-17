//
//  Stream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class Stream<T> {
    
    private let streamListenState: StreamListenState
    
    required init(streamListenState: StreamListenState = .singleListener) {
        self.streamListenState = streamListenState
    }
    
    typealias ListenCallbackType = ((T) -> Void)?
    typealias CatchErrorCallbackType = ((Any) -> Void)?
    
    var listernerCallList: [ListenCallbackType] = []
    var catchErrorCallList: [CatchErrorCallbackType] = []
    
    @discardableResult
    public func listen(received callback: @escaping (T) -> Void) -> Self {
        
        switch streamListenState {
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
        
        switch streamListenState {
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
}
