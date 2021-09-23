//
//  VideoLauncher.swift
//  Movie Database App
//
//  Created by Hasan Aygünoglu on 19.08.2021.
//

import UIKit
import AVFoundation

class BasicVideoPlayer: UIView {
    
    private var timeObserver: Double?
    private var isPlaying = false
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    private var hdExists = false
    private var fhdExists = false
    private var sdExists = false
    private var mp3Exists = false
    
    private var sdURL: String = ""
    private var hdURL: String = ""
    private var mp3URL: String = ""
    private var fhdURL: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    public func addSD(sd: String) {
        sdURL = sd
    }
    
    public func addHD(hd: String) {
        hdURL = hd
    }
    
    public func addFHD(fhd: String) {
        fhdURL = fhd
    }
    
    public func addMP3(mp3: String) {
        mp3URL = mp3
    }
    
    public func initializePlayer( ) {
        if hdURL != "" {
            hdExists = true
        }
        if sdURL != "" {
            sdExists = true
        }
        if mp3URL != "" {
            mp3Exists = true
        }
        if fhdURL != "" {
            fhdExists = true
        }
        
        if hdExists {
            setupPlayerView(url: hdURL)
            setupPlayerLayout()
            timeObserverSetup()
        }else if sdExists {
            setupPlayerView(url: sdURL)
            setupPlayerLayout()
            timeObserverSetup()
        }else if fhdExists {
            setupPlayerView(url: fhdURL)
            setupPlayerLayout()
            timeObserverSetup()
        }else if mp3Exists {
            setupPlayerView(url: mp3URL)
            setupPlayerLayout()
            timeObserverSetup()
        }else {
            setupPlayerView(url: "https://h265.donanimhaber.com/snapchat2306rev3_hd.mp4")
            setupPlayerLayout()
            timeObserverSetup()
        }
    }
    
    private func setupPlayerView(url: String) {

        if let defaultURL = URL(string: url) {
            player = AVPlayer(url: defaultURL)
            
            playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
        
            player?.play()
            isPlaying = true
            player?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: .new, context: nil)
        }
        
    }
    
    public func handleOrientation(newFrame: CGRect) {
        playerLayer.frame = newFrame
        self.frame = newFrame
        setupPlayerLayout()
    }
    
    public func stopPlaying() {
        player?.pause()
    }
    
    // Creating control layout elements
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = .white
        aiv.style = UIActivityIndicatorView.Style.large
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()

    private lazy var controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        //tap recognizer to hide/show controls
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleControlsContainerTapped))
        view.addGestureRecognizer(tap)
        return view
    }()

    private let videoDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()

    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isHidden = true
        return label
    }()

    private lazy var progressBar: UISlider = {
        let bar = UISlider()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.minimumTrackTintColor = .red
        bar.maximumTrackTintColor = .white
        bar.value = 0.0
        bar.isHidden = true
        bar.addTarget(self, action: #selector(sliderValueChanged(sender:event:)), for: .valueChanged)
        return bar
    }()

    private lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true

        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()

    private lazy var forwardJumpButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "forward")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true

        button.addTarget(self, action: #selector(handleForwardJump), for: .touchUpInside)
        return button
    }()

    private lazy var backwardsJumpButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "backwards")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true

        button.addTarget(self, action: #selector(handleBackwardsJump), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchToSD: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "sd")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.tag = 0

        button.addTarget(self, action: #selector(handleQualitySwitch), for: .touchUpInside)
        return button
    }()

    private lazy var switchToHD: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "hd")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.tag = 1

        button.addTarget(self, action: #selector(handleQualitySwitch), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchToFHD: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "fhd")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.tag = 2

        button.addTarget(self, action: #selector(handleQualitySwitch), for: .touchUpInside)
        return button
    }()

    private lazy var switchToMP3: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "mp3")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.tag = 3

        button.addTarget(self, action: #selector(handleQualitySwitch), for: .touchUpInside)
        return button
    }()

    private lazy var switchToFullScreen: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "fullscreen")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true

        button.addTarget(self, action: #selector(handleFullScreenSwitch), for: .touchUpInside)
        return button
    }()
    
    //This is where initial loading gets completed, perfect time to start showing buttons etc.
    internal override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            switch status {
            
            case .readyToPlay:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.controlsContainerView.backgroundColor = .clear
                    self.activityIndicatorView.stopAnimating()
                    //set value to duration label
                    if let duration = self.player?.currentItem?.duration {
                        let durationSeconds = CMTimeGetSeconds(duration)
                        guard !(durationSeconds.isNaN || durationSeconds.isInfinite) else { return }

                        let secondsText = Int(durationSeconds) % 60
                        let minutesText = String(format: "%02d", Int(durationSeconds) / 60)

                        self.videoDurationLabel.text = "\(minutesText):\(secondsText)"
                    }
                    //show controls
                    self.showControls()
                }
            case .failed:
                print("error while loading video")
            case .unknown:
                print("not yet ready")
            @unknown default:
                print("not yet ready")
                
            }
            //hide controls after two seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.hideControls()
            }

        }
    }
    
    // observes current time, perfect place to keep track of the time and update the slider
    private func timeObserverSetup() {
        player?.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main, using: { time in
            self.updateSlider(currentTime: time)
            self.updateCurrentTime(currentTime: time)
        })
    }
    
    // slider behaviour gets erratic without this
    private func removeTimeObserver( ) {
        if let token = timeObserver {
            if self.player?.rate == 1.0 {
                self.player?.removeTimeObserver(token)
                timeObserver = nil
            }
        }
    }
    
    //update slider value
    private func updateSlider (currentTime: CMTime) {
        
        if let duration = self.player?.currentItem?.duration {
            let duration = CMTimeGetSeconds(duration), time = CMTimeGetSeconds(currentTime)
            let progress = (time/duration)
            self.progressBar.value = Float(progress)
        }
    }
    
    //update currentTimeLabel's value
    private func updateCurrentTime (currentTime: CMTime) {
        
        let currentSeconds = CMTimeGetSeconds(currentTime)
        let secondsString = String(format: "%02d", Int(currentSeconds) % 60)
        let minutesText = String(format: "%02d", Int(currentSeconds) / 60)
        
        self.currentTimeLabel.text = "\(minutesText):\(secondsString)"

    }
    
    private func showControls ( ) {
        pausePlayButton.isHidden = false
        forwardJumpButton.isHidden = false
        backwardsJumpButton.isHidden = false
        switchToHD.isHidden = false
        switchToSD.isHidden = false
        switchToFHD.isHidden = false
        switchToMP3.isHidden = false
        progressBar.isHidden = false
        currentTimeLabel.isHidden = false
        videoDurationLabel.isHidden = false
        switchToFullScreen.isHidden = false
    }
    
    private func hideControls ( ) {
        pausePlayButton.isHidden = true
        forwardJumpButton.isHidden = true
        backwardsJumpButton.isHidden = true
        switchToHD.isHidden = true
        switchToSD.isHidden = true
        switchToFHD.isHidden = true
        switchToMP3.isHidden = true
        progressBar.isHidden = true
        currentTimeLabel.isHidden = true
        videoDurationLabel.isHidden = true
        switchToFullScreen.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Setup player control layout here inside this extension
extension BasicVideoPlayer {
    
    private func setupPlayerLayout ( ) {
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        controlsContainerView.addSubview(forwardJumpButton)
        forwardJumpButton.leftAnchor.constraint(equalTo: pausePlayButton.rightAnchor, constant: 15).isActive = true
        forwardJumpButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        forwardJumpButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        forwardJumpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        controlsContainerView.addSubview(backwardsJumpButton)
        backwardsJumpButton.rightAnchor.constraint(equalTo: pausePlayButton.leftAnchor, constant: -15).isActive = true
        backwardsJumpButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backwardsJumpButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backwardsJumpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(switchToFullScreen)
        switchToFullScreen.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        switchToFullScreen.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        switchToFullScreen.widthAnchor.constraint(equalToConstant: 20).isActive = true
        switchToFullScreen.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainerView.addSubview(videoDurationLabel)
        videoDurationLabel.rightAnchor.constraint(equalTo: switchToFullScreen.leftAnchor, constant: -8).isActive = true
        videoDurationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        videoDurationLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoDurationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(progressBar)
        progressBar.rightAnchor.constraint(equalTo: videoDurationLabel.leftAnchor, constant: -2).isActive = true
        progressBar.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 2).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlsContainerView.addSubview(switchToMP3)
        switchToMP3.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        switchToMP3.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        switchToMP3.widthAnchor.constraint(equalToConstant: 28).isActive = true
        switchToMP3.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        controlsContainerView.addSubview(switchToSD)
        switchToSD.rightAnchor.constraint(equalTo: switchToMP3.leftAnchor, constant: -5).isActive = true
        switchToSD.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        switchToSD.widthAnchor.constraint(equalToConstant: 35).isActive = true
        switchToSD.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        controlsContainerView.addSubview(switchToHD)
        switchToHD.rightAnchor.constraint(equalTo: switchToSD.leftAnchor, constant: -4).isActive = true
        switchToHD.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        switchToHD.widthAnchor.constraint(equalToConstant: 35).isActive = true
        switchToHD.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        controlsContainerView.addSubview(switchToFHD)
        switchToFHD.rightAnchor.constraint(equalTo: switchToHD.leftAnchor, constant: -4).isActive = true
        switchToFHD.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        switchToFHD.widthAnchor.constraint(equalToConstant: 35).isActive = true
        switchToFHD.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
}

// Handling player controls inside this extension
extension BasicVideoPlayer {
    
    @objc private func handleForwardJump ( ) {
        
        let seekDuration: Float64 = 10
        
        guard let duration = player?.currentItem?.duration else { return }
        
        let playerCurrentTime = CMTimeGetSeconds((player?.currentTime())!)
        let newTime = playerCurrentTime + seekDuration
        
        if newTime < CMTimeGetSeconds(duration) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player?.seek(to: time)
        }
        
    }
    
    @objc private func handleBackwardsJump ( ) {
        
        let seekDuration: Float64 = 10
        
        guard let duration = player?.currentItem?.duration else { return }
        
        let playerCurrentTime = CMTimeGetSeconds((player?.currentTime())!)
        let newTime = playerCurrentTime - seekDuration
        
        if newTime < CMTimeGetSeconds(duration) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player?.seek(to: time)
        }
    }
    
    @objc private func handlePause( ) {
        print("button clicked")
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        }else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    @objc private func sliderValueChanged(sender: UISlider, event: UIEvent) {

        let sliderValue = sender.value
        guard let touchEvent = event.allTouches?.first else { return }
        
        switch touchEvent.phase {
        
            case .began:
                player?.pause()
                removeTimeObserver()
                
            case .moved:
                showControls()
                
            case .ended:
                if let duration = self.player?.currentItem?.duration {
                    let currenTimeAfterDrag = Float(CMTimeGetSeconds(duration)) * sliderValue
                    player?.seek(to: CMTime(value: CMTimeValue(currenTimeAfterDrag), timescale: 1))
                    player?.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.hideControls()
                    }
                }

            default: ()
        }
    }
    
    @objc private func handleQualitySwitch (_ sender: UIButton) {
        
        var newURL: URL? {
            switch sender.tag {
            case 0:
                return URL(string: sdURL)
            case 1:
                return URL(string: hdURL)
            case 2:
                return URL(string: fhdURL)
            case 3:
                return URL(string: mp3URL)
            default:
                return URL(string: hdURL)
            }
        }
        
        if let videoURL = newURL {
            if let currentTime = player?.currentItem?.currentTime() {
                let sdPlayerItem = AVPlayerItem(url: videoURL as URL)
                player?.pause()
                player?.replaceCurrentItem(with: sdPlayerItem)
                player?.seek(to: currentTime)
                player?.play()
            }
        }else {
            print("error")
        }
        
    }
    
    @objc private func handleControlsContainerTapped() {
        
        showControls()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hideControls()
        }

    }
    
    @objc private func handleFullScreenSwitch ( ) {
        
        if UIDevice.current.orientation.rawValue == 0 || UIDevice.current.orientation.rawValue == 1  {
            UIDevice.current.setValue(UIDeviceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        } else if UIDevice.current.orientation.isLandscape {
            UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
        }
        
    }
}
