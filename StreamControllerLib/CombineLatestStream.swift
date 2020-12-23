//
//  CombineLatestStream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 22/12/2020.
//

import Foundation

final public class CombineLatestStream<T> {
    
    private class CombineValues {
        var valueA: Any?
        var valueB: Any?
        var valueC: Any?
        var valueD: Any?
    }
    
    private let streamController: StreamController<T>
   
    
    public init() {
        streamController = StreamController<T>()
    }
    
    @discardableResult
    public func combine2<A, B>(streamA: Stream<A>, streamB: Stream<B>, combineCallback: @escaping ( (A, B) -> T)) -> Stream<T> {
        
        let combineValue = CombineValues()
      
        let checkIfReady = {
            self.checkCombineOperation2Status(combineValue: combineValue, streamA: streamA, streamB: streamB, combineCallback: combineCallback)
        }
        
        streamA.listen { value in
            combineValue.valueA = value
            checkIfReady()
        }
        streamB.listen { value in
            combineValue.valueB = value
            checkIfReady()
        }
   
        return streamController.stream
    }
    
    private func checkCombineOperation2Status<A, B>(combineValue: CombineValues, streamA: Stream<A>, streamB: Stream<B>, combineCallback: @escaping ( (A, B) -> T)) {
     
        guard let valueA = combineValue.valueA as? A,
              let valueB = combineValue.valueB as? B else {
            return
        }
        let result = combineCallback(valueA, valueB)
        self.streamController.sink.add(result)
        self.resetCombineValues(combineValue: combineValue)
    }
    
    @discardableResult
    public func combine3<A, B, C>(streamA: Stream<A>, streamB: Stream<B>, streamC: Stream<C>, combineCallback: @escaping ( (A, B, C) -> T)) -> Stream<T> {
        
        let combineValue = CombineValues()
      
        let checkIfReady = {
            self.checkCombineOperation3Status(combineValue: combineValue,
                                              streamA: streamA,
                                              streamB: streamB,
                                              streamC: streamC,
                                              combineCallback: combineCallback)
        }
        
        streamA.listen { value in
            combineValue.valueA = value
            checkIfReady()
        }
        streamB.listen { value in
            combineValue.valueB = value
            checkIfReady()
        }
   
        return streamController.stream
    }
    
    private func checkCombineOperation3Status<A, B, C>(combineValue: CombineValues, streamA: Stream<A>, streamB: Stream<B>, streamC: Stream<C>, combineCallback: @escaping ( (A, B, C) -> T)) {
     
        guard let valueA = combineValue.valueA as? A,
              let valueB = combineValue.valueB as? B,
              let valueC = combineValue.valueC as? C
              else { return }
        let result = combineCallback(valueA, valueB, valueC)
        self.streamController.sink.add(result)
        self.resetCombineValues(combineValue: combineValue)
    }
    
    
    @discardableResult
    public func combine4<A, B, C, D>(streamA: Stream<A>, streamB: Stream<B>, streamC: Stream<C>, streamD: Stream<D>, combineCallback: @escaping ( (A, B, C, D) -> T)) -> Stream<T> {
        
        let combineValue = CombineValues()
      
        let checkIfReady = {
            self.checkCombineOperation4Status(combineValue: combineValue,
                                              streamA: streamA,
                                              streamB: streamB,
                                              streamC: streamC,
                                              streamD: streamD,
                                              combineCallback: combineCallback)
        }
        
        streamA.listen { value in
            combineValue.valueA = value
            checkIfReady()
        }
        streamB.listen { value in
            combineValue.valueB = value
            checkIfReady()
        }
   
        return streamController.stream
    }
    
    private func checkCombineOperation4Status<A, B, C, D>(combineValue: CombineValues, streamA: Stream<A>, streamB: Stream<B>, streamC: Stream<C>, streamD: Stream<D>, combineCallback: @escaping ( (A, B, C, D) -> T)) {
     
        guard let valueA = combineValue.valueA as? A,
              let valueB = combineValue.valueB as? B,
              let valueC = combineValue.valueC as? C,
              let valueD = combineValue.valueD as? D
              else { return }
        let result = combineCallback(valueA, valueB, valueC, valueD)
        self.streamController.sink.add(result)
        self.resetCombineValues(combineValue: combineValue)
    }
    
    private func resetCombineValues(combineValue: CombineValues) {
        combineValue.valueA = nil
        combineValue.valueB = nil
        combineValue.valueC = nil
        combineValue.valueD = nil
    }
    
}
