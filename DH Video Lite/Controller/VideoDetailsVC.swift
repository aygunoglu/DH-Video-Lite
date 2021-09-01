//
//  VideoDetailsVC.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 28.08.2021.
//

import UIKit

class VideoDetailsVC: UIViewController {

    //MARK: Properties
    
    var videoPlayer: VideoPlayerView?
    var tableView = UITableView()
    
    var getTitle = String()
    var getTitleBackgroundColor = String()
    var getTitleLabelColor = String()
    var getShortContent = String()
    var getDate = String()
    var getCategory = String()
    var getSDURL = String()
    var getHDURL = String()
    var getFHDURL = String()
    var getMp3URL = String()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoPlayerSetup()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            handleVideoPlayerWhenLandscape()
        }else if UIDevice.current.orientation.isPortrait{
            handleVideoPlayerWhenPortrait()
        }
    }

    //MARK: Helpers
    
    func configureTableView( ) {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        
        if let safeVideoPlayer = videoPlayer {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: safeVideoPlayer.bottomAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
        
        tableView.register(UINib(nibName: Constants.descriptionCell, bundle: nil), forCellReuseIdentifier: Constants.descriptionCell)
        tableView.register(UINib(nibName: Constants.titleCell, bundle: nil), forCellReuseIdentifier: Constants.titleCell)
        tableView.register(DateDownloadCell.self, forCellReuseIdentifier: Constants.DateDownloadCell)
        
    }

    func setTableViewDelegates( ) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func videoPlayerSetup( ) {
        let videoPlayerHeight = self.view.frame.size.width * 9 / 16
        let videoPlayerWidth = self.view.frame.size.width
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: videoPlayerWidth, height: videoPlayerHeight)
        videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
        videoPlayer?.addSD(sd: getSDURL)
        videoPlayer?.addHD(hd: getHDURL)
        videoPlayer?.addFHD(fhd: getFHDURL)
        videoPlayer?.addMP3(mp3: getMp3URL)
        videoPlayer?.initializePlayer()
        
        view.addSubview(videoPlayer!)
        self.videoPlayer?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func handleVideoPlayerWhenLandscape() {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = true
            let newHeight = self.view.frame.size.height
            let newWidth = self.view.frame.size.height * 16 / 9
            let newVideoLayer = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
            self.videoPlayer?.handleOrientation(newFrame: newVideoLayer)
            self.videoPlayer?.frame = newVideoLayer
            self.videoPlayer?.center = self.view.center
            self.view.backgroundColor = .black
        }
    }
    
    func handleVideoPlayerWhenPortrait( ) {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            let newWidth = self.view.frame.size.width
            let newHeight = self.view.frame.size.width * 9 / 16
            let newVideoLayer = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
            self.videoPlayer?.handleOrientation(newFrame: newVideoLayer)
            self.videoPlayer?.frame = newVideoLayer
            self.videoPlayer?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.view.backgroundColor = .systemPink
        }
    }

}

extension VideoDetailsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleCell = tableView.dequeueReusableCell(withIdentifier: Constants.titleCell, for: indexPath) as! TitleCell
        let descriptionCell = tableView.dequeueReusableCell(withIdentifier: Constants.descriptionCell, for: indexPath) as! DescriptionCell
        let dateDownloadCell = tableView.dequeueReusableCell(withIdentifier: Constants.DateDownloadCell, for: indexPath) as! DateDownloadCell
        
        if indexPath.row == 0 {
            titleCell.titleLabel.text = getTitle
            titleCell.titleLabel.textColor = hexStringToUIColor(hex: getTitleLabelColor)
            titleCell.contentView.backgroundColor =  hexStringToUIColor(hex: getTitleBackgroundColor)
            return titleCell
        }else if indexPath.row == 1 {
            dateDownloadCell.contentView.backgroundColor = hexStringToUIColor(hex: getTitleBackgroundColor)
            dateDownloadCell.dateLabel.text = getDate
            dateDownloadCell.categoryLabel.text = getCategory
            dateDownloadCell.delegate = self
            return dateDownloadCell
        }else if indexPath.row == 2 {
            descriptionCell.descriptionLabel.text = getShortContent
            return descriptionCell
        }else {
            return UITableViewCell()
        }
    }

}

// MARK: Download pop-up view set up

extension VideoDetailsVC: UIViewControllerTransitioningDelegate {
    @objc func showDownloadOptions() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension VideoDetailsVC: DateDownloadCellDelegate {
    func handleDownloadButtonTapped() {
        showDownloadOptions()
    }
    
}
