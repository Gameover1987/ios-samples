
import Foundation

class PlaybackInfo {
   
    var duration: TimeInterval
    var currentTime: TimeInterval
    
    init (duration: TimeInterval, currentTime: TimeInterval) {
        self.duration = duration
        self.currentTime = currentTime
    }
}
