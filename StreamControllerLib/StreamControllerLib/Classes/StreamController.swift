import Foundation

public class StreamController<T> {
    
    public let stream: Stream<T>
    public let sink: EventSink<T>
    
    public init(streamListenType: StreamListenType = .singleListener) {
        switch streamListenType {
        case .singleListener:
            stream = Stream<T>()
            break
        case .multipleListener:
            stream = Stream<T>(streamListenState: .multipleListener)
            break
        }
        sink = EventSink<T>(stream: stream)
    }
    
    init(stream: Stream<T>) {
        self.stream = stream
        sink = EventSink<T>(stream: stream)
    }
    
}
