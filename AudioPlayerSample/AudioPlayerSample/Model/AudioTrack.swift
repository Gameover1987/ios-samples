
import Foundation
import UIKit

class AudioTrack {
    var track: String
    var performer: String
    var image: UIImage
    var url: URL
    
    init (track: String, performer: String, image: UIImage, url: URL) {
        self.track = track
        self.performer = performer
        self.image = image
        self.url = url
    }
}
