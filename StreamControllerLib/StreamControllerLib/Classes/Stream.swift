//
//  Stream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class Stream<T> {
    
    private let type: StreamType
    
    required init(type: StreamType = .singleListener) {
        self.type = type
    }
    
    typealias ListenCallbackType = ((T) -> Void)?
    typealias CatchErrorCallbackType = ((Any) -> Void)?
    
    var listernerCallList: [ListenCallbackType] = []
    var catchErrorCallList: [CatchErrorCallbackType] = []
    
    @discardableResult
    public func listen(received callback: @escaping (T) -> Void) -> Self {
        
        switch type {
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
        
        switch type {
        case .singleListener:
            catchErrorCallList = [callback]
            break
        case .multipleListener:
            catchErrorCallList.append(callback)
            break
        }
        return self
    }
}
