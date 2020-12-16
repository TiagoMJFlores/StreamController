import Foundation

public class StreamController<T> {
    
    public let stream = Stream<T>()
    public let sink: EventSink<T>
    
    public init() {
        sink = EventSink<T>(stream: stream)
    }
    

}
