import Foundation

public class StreamController<T> {
    
    public let stream: Stream<T>
    public let sink: EventSink<T>
    
    public init() {
        stream = Stream<T>()
        sink = EventSink<T>(stream: stream)
    }
    
    init(stream: Stream<T>) {
        self.stream = stream
        sink = EventSink<T>(stream: stream)
    }
    
    public static func broadcast() -> StreamController<T> {
        let stream = Stream<T>(type: .multipleListener)
        let streamController = StreamController<T>(stream: stream)
        return streamController
    }
    
}
