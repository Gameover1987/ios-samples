
import Foundation
import AVFoundation

class AudioPlayerViewModel: NSObject {
    private let playlistProvider: PlaylistProviderProtocol
    
    private var player: AVAudioPlayer!
    private lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: #selector(updatePlaybackStatus))
    
    init(playlistProvider: PlaylistProviderProtocol) {
        self.playlistProvider = playlistProvider
        
        super.init()
        
        tracks = playlistProvider.getAudioTracks()
        
        displayLink.add(to: .main, forMode: .common)
    }
    
    /// Коллекция треков
    var tracks = [AudioTrack]()
    
    ///  Номер текущего трека
    var counter: Int = 0
    
    /// Событие измения позиции проигрывателя во время воспроизведения
    var playerPositionChangedAction: ((_ info: PlaybackInfo) -> Void)?
    
    /// Событие окончания проигрывания трека
    var endOfTrackReachedAction: (() -> Void)?
    
    /// Возвращает текущий трек
    func getCurrentTrack() -> AudioTrack {
        return tracks[counter]
    }
    
    /// Возвращает состояние проигрывателя (Play \ Pause)
    func isPlaying() -> Bool {
        return player.isPlaying
    }
    
    /// Загружает текущий трек в аудиопроигрыватель
    func loadCurrentTrack() {
        do {
            let track = tracks[counter]
            
            try player = AVAudioPlayer(contentsOf: track.url)
            player.prepareToPlay()
            player.delegate = self
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.playback)
            } catch {
                ()
            }
        } catch {
            ()
        }
    }
    
    /// Начать воспроизведение
    func play() {
        player.play()
    }
    
    /// Пауза
    func pause() {
        player.pause()
    }
    
    /// Можно ли переключать треки назад
    func canMoveBack() -> Bool {
        return counter > 0
    }
    
    /// Переключить трек назад
    func moveBack() {
        if (!canMoveBack()) {
            return
        }
        
        counter -= 1
        
        let isPlaying = player.isPlaying
        
        loadCurrentTrack()
        
        if (isPlaying) {
            player.play()
        }
    }
    
    /// Можно ли переключить трек вперед
    func canMoveNext() -> Bool {
        return counter + 1 < tracks.count
    }
    
    /// Переключить трек вперед
    func moveNext() {
        if (!canMoveNext()) {
            return
        }
        
        counter += 1
        
        let isPlaying = player.isPlaying
        
        loadCurrentTrack()
        
        if (isPlaying) {
            player.play()
        }
    }
    
    /// Начать навигирование (событие навигации не будут приходить)
    func beginNavigation() {
        displayLink.isPaused = true
    }
    
    /// Закончить навигирование
    func endNavigation(position: Double) {
        let newPosition = player.duration * position
        player.currentTime = newPosition
        
        displayLink.isPaused = false
    }
    
    @objc private func updatePlaybackStatus() {
        if (player == nil) {
            return
        }
        
        let playbackInfo = PlaybackInfo(duration: player.duration, currentTime: player.currentTime)
        
        playerPositionChangedAction?(playbackInfo)
    }
}

extension AudioPlayerViewModel : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        endOfTrackReachedAction?()
    }
}
