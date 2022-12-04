
import UIKit
import AVFoundation
import SnapKit

class AudioPlayerViewController: UIViewController {
    
    private let audioPlayerView = AudioPlayerView()
    
    private let audioPlayerViewModel: AudioPlayerViewModel
    
    init(audioPlayerViewModel: AudioPlayerViewModel) {
        self.audioPlayerViewModel = audioPlayerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view = audioPlayerView
        audioPlayerView.layoutSubViews()
        
        audioPlayerView.playPauseTrackAction = playPauseButtonAction
        audioPlayerView.nextTrackAction = nextButtonAction
        audioPlayerView.prevTrackAction = prevButtonAction
        audioPlayerView.beginNavigatingAction = beginNavigatingAction
        audioPlayerView.endNavigatingAction = endNavigatingAction
        
        audioPlayerViewModel.playerPositionChangedAction = playerPositionChangedAction(playbackInfo:)
        audioPlayerViewModel.endOfTrackReachedAction = endOfTrackReachedAction
        
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayerView.displayTrackInfo(track: audioPlayerViewModel.tracks[0])
        audioPlayerViewModel.loadCurrentTrack()
    }
    
    private func prevButtonAction() {
        
        self.audioPlayerViewModel.moveBack()
        
        audioPlayerView.displayTrackInfo(track: audioPlayerViewModel.getCurrentTrack())
        audioPlayerView.updateNavigationButtons(canMoveBack: audioPlayerViewModel.canMoveBack(),
                                                canMoveForward: audioPlayerViewModel.canMoveNext())
        
        audioPlayerView.updatePlayerState(isPlaying: audioPlayerViewModel.isPlaying())
    }
    
    private func nextButtonAction() {
        
        self.audioPlayerViewModel.moveNext()
        
        audioPlayerView.displayTrackInfo(track: audioPlayerViewModel.getCurrentTrack())
        audioPlayerView.updateNavigationButtons(canMoveBack: audioPlayerViewModel.canMoveBack(),
                                                canMoveForward: audioPlayerViewModel.canMoveNext())
        
        audioPlayerView.updatePlayerState(isPlaying: audioPlayerViewModel.isPlaying())
    }
    
    private func playPauseButtonAction() {
        if (audioPlayerViewModel.isPlaying()) {
            audioPlayerViewModel.pause()
        } else {
            audioPlayerViewModel.play()
        }
        
        audioPlayerView.updatePlayerState(isPlaying: audioPlayerViewModel.isPlaying())
    }
    
    private func playerPositionChangedAction(playbackInfo: PlaybackInfo) {
        audioPlayerView.updatePlaybackInfo(playbackInfo: playbackInfo)
    }
    
    private func endOfTrackReachedAction() {
        audioPlayerView.updatePlayerState(isPlaying: false)
    }
    
    private func beginNavigatingAction() {
        audioPlayerViewModel.beginNavigation()
    }
    
    private func endNavigatingAction(position: Double) {
        audioPlayerViewModel.endNavigation(position: position)
    }
}
