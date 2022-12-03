
import UIKit
import AVFoundation
import SnapKit

class AudioPlayerViewController: UIViewController {
    
    private let playlistProvider: PlaylistProviderProtocol
    
    private var tracks = [AudioTrack]()
    
    private var counter: Int = 0
    
    private var player: AVAudioPlayer!
    private var updater : CADisplayLink! = nil
    
    private lazy var performerImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var auidoTrackLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var performerLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: #selector(updatePlaybackStatus))
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.3
        slider.addTarget(self, action: #selector(didBeginDraggingSlider), for: .touchDown)
        slider.addTarget(self, action: #selector(didEndDraggingSlider), for: .valueChanged)
        return slider
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "forward.end.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var prevButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "backward.end.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(prevButtonAction), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private var playButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "play.circle", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var pauseButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "pause.circle", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc func didBeginDraggingSlider() {
        displayLink.isPaused = true
    }
    
    @objc func didEndDraggingSlider() {
        let newPosition = player.duration * Double(slider.value)
        player.currentTime = newPosition
        
        displayLink.isPaused = false
    }
    
    init(playlistProvider: PlaylistProviderProtocol) {
        self.playlistProvider = playlistProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutSubViews()
        
        tracks = playlistProvider.getAudioTracks()
        
        displayLink.add(to: .main, forMode: .common)
        
        let track = tracks[0]
        
        performerImage.image = track.image
        performerLabel.text = track.performer
        auidoTrackLabel.text = track.track
        
        configureAudioPlayer(track: track)
    }
    
    private func beginPlayback(track: AudioTrack) {
        performerImage.image = track.image
        performerLabel.text = track.performer
        auidoTrackLabel.text = track.track
        
        let isPLaying = player.isPlaying
        
        configureAudioPlayer(track: track)
        
        if (isPLaying) {
            player.play()
        }
    }
    
    private func configureAudioPlayer(track: AudioTrack) {
        do {
            try player = AVAudioPlayer(contentsOf: track.url)
            player.prepareToPlay()
            
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
    
    @objc func nextButtonAction() {
       
        counter += 1
        
        prevButton.isEnabled = true
        nextButton.isEnabled = true
        if (counter + 1 == tracks.count) {
            nextButton.isEnabled = false
        }
        
        beginPlayback(track: tracks[counter])
    }
    
    @objc func prevButtonAction() {
        counter -= 1
        
        prevButton.isEnabled = true
        nextButton.isEnabled = true
        if (counter == 0) {
            prevButton.isEnabled = false
        }
        
        beginPlayback(track: tracks[counter])
    }
    
    @objc func updatePlaybackStatus() {
        if (player == nil) {
            return
        }
        
        let playbackProgress = Float(player.currentTime / player.duration)
        
        slider.setValue(playbackProgress, animated: true)
        
        print(playbackProgress)
    }
    
    @objc func playPauseButtonAction() {
        
        if (player.isPlaying) {
            player.pause()
            pauseButton.isHidden = true
            playButton.isHidden = false;
        }
        else {
            player.play()
            pauseButton.isHidden = false
            playButton.isHidden = true
        }
    }
    
    private func layoutSubViews() {
        view.addSubview(performerImage)
        view.addSubview(auidoTrackLabel)
        view.addSubview(performerLabel)
        view.addSubview(slider)

        view.addSubview(prevButton)
        view.addSubview(nextButton)
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        
        performerImage.snp.makeConstraints{ maker -> Void in
            maker.leftMargin.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.rightMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
            maker.height.equalTo(view.bounds.height / 2)
        }
        
        auidoTrackLabel.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(performerImage.snp.bottom).offset(16)
            maker.rightMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        performerLabel.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(auidoTrackLabel.snp.bottom).offset(16)
            maker.rightMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        slider.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(performerLabel.snp.bottom).offset(16)
            maker.rightMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        playButton.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(16)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        pauseButton.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(16)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        prevButton.snp.makeConstraints { maker -> Void in
            maker.right.equalTo(playButton.snp.left).offset(-10)
            maker.topMargin.equalTo(slider.snp.bottom).offset(36)
        }
        
        nextButton.snp.makeConstraints { maker -> Void in
            maker.left.equalTo(playButton.snp.right).offset(10)
            maker.topMargin.equalTo(slider.snp.bottom).offset(36)
        }
    }
}
