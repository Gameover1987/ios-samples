
import Foundation
import UIKit
import SnapKit

class AudioPlayerView : UIView {
    
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
    
    private lazy var totalDurationLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var currrentPositionLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
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
    
    var playPauseTrackAction: (() -> Void)?
    var prevTrackAction: (() -> Void)?
    var nextTrackAction: (() -> Void)?
    
    var beginNavigatingAction: (() -> Void)?
    var endNavigatingAction: ((_ position: Double) -> Void)?
    
    /// Обновление кнопок навигации
    func updateNavigationButtons(canMoveBack: Bool, canMoveForward: Bool) {
        prevButton.isEnabled = canMoveBack
        nextButton.isEnabled = canMoveForward
    }
    
    /// Отображение инфы о треке
    func displayTrackInfo(track: AudioTrack) {
        performerImage.image = track.image
        performerLabel.text = track.performer
        auidoTrackLabel.text = track.track
    }
    
    /// Обновление состояния Play \ Pause
    func updatePlayerState(isPlaying: Bool) {
        if (isPlaying) {
            pauseButton.isHidden = false
            playButton.isHidden = true
        }
        else {
            pauseButton.isHidden = true
            playButton.isHidden = false;
        }
    }
    
    /// Обновление позиции проигрывателя
    func updatePlaybackInfo(playbackInfo: PlaybackInfo) {
        let playbackProgress = Float(playbackInfo.currentTime / playbackInfo.duration)
        
        slider.setValue(playbackProgress, animated: true)
        print(playbackProgress)
        currrentPositionLabel.text = getFormatedTime(timeDuration: playbackInfo.currentTime)
        totalDurationLabel.text = getFormatedTime(timeDuration: playbackInfo.duration)
    }
    
    func layoutSubViews() {
        addSubview(performerImage)
        addSubview(auidoTrackLabel)
        addSubview(performerLabel)
        addSubview(slider)
        addSubview(totalDurationLabel)
        addSubview(currrentPositionLabel)
        
        addSubview(prevButton)
        addSubview(nextButton)
        addSubview(playButton)
        addSubview(pauseButton)
        
        performerImage.snp.makeConstraints{ maker -> Void in
            maker.leftMargin.equalTo(safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(safeAreaLayoutGuide).offset(16)
            maker.rightMargin.equalTo(safeAreaLayoutGuide).offset(-16)
            maker.height.equalTo(400)
        }
        
        auidoTrackLabel.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(performerImage.snp.bottom).offset(16)
            maker.rightMargin.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        performerLabel.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(auidoTrackLabel.snp.bottom).offset(16)
            maker.rightMargin.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        slider.snp.makeConstraints { maker -> Void in
            maker.leftMargin.equalTo(safeAreaLayoutGuide).offset(16)
            maker.topMargin.equalTo(performerLabel.snp.bottom).offset(16)
            maker.rightMargin.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        totalDurationLabel.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(8)
            maker.rightMargin.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        currrentPositionLabel.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(8)
            maker.left.equalTo(safeAreaLayoutGuide).offset(5)
        }
        
        playButton.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(16)
            maker.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
        
        pauseButton.snp.makeConstraints { maker -> Void in
            maker.topMargin.equalTo(slider.snp.bottom).offset(16)
            maker.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
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
    
    @objc func didBeginDraggingSlider() {
       beginNavigatingAction?()
    }
    
    @objc func didEndDraggingSlider() {
        endNavigatingAction?(Double(slider.value))
    }
    
    @objc private func nextButtonAction() {
        nextTrackAction?()
    }
    
    @objc private func prevButtonAction() {
        prevTrackAction?()
    }
    
    @objc private func playPauseButtonAction() {
        playPauseTrackAction?()
    }
    
    private func getFormatedTime(timeDuration: Double) -> String {
        let minutes = Int(timeDuration) / 60 % 60
        let seconds = Int(timeDuration) % 60
        let strDuration = String(format:"%2d:%02d", minutes, seconds)
        return strDuration
    }
}
