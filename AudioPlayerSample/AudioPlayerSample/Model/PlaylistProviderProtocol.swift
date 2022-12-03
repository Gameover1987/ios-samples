
import Foundation
import UIKit

protocol PlaylistProviderProtocol {
    func getAudioTracks() -> [AudioTrack]
}

final class PlaylistProvider : PlaylistProviderProtocol {
    
    private init() {
        
    }
    
    static let shared: PlaylistProvider = .init()
    
    func getAudioTracks() -> [AudioTrack] {
        var playlist = [AudioTrack]()
        
        
        let acdc = AudioTrack(track: "Back In Black",
                              performer: "AC/DC",
                              image: UIImage(named: "Acdc")!,
                              url: Bundle.main.url(forResource: "ACDC - Back In Black", withExtension: "mp3")!)
        
        let deepPurple = AudioTrack(track: "Burn",
                                   performer: "Deep Purple",
                                   image: UIImage(named: "DeepPurple")!,
                                   url: Bundle.main.url(forResource: "Deep Purple - Burn", withExtension: "mp3")!)
        
        let ironMaiden = AudioTrack(track: "The Trooper",
                                   performer: "Iron Maiden",
                                   image: UIImage(named: "IronMaiden")!,
                                   url: Bundle.main.url(forResource: "Iron Maiden - The Trooper", withExtension: "mp3")!)
        
        let metallica = AudioTrack(track: "Master of puppets",
                                   performer: "Metallica",
                                   image: UIImage(named: "Metallica")!,
                                   url: Bundle.main.url(forResource: "Metallica - Master Of Puppets", withExtension: "mp3")!)
        let archEnemy = AudioTrack(track: "No Gods, No Masters",
                                   performer: "Arch Enemy",
                                   image: UIImage(named: "ArchEnemy")!,
                                   url: Bundle.main.url(forResource: "Arch Enemy - No Gods, No Masters", withExtension: "mp3")!)
        playlist.append(acdc)
        playlist.append(archEnemy)
        playlist.append(deepPurple)
        playlist.append(ironMaiden)
        playlist.append(metallica)
        
        return playlist
    }
    
    
}
