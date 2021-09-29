//
//  VideoListVC.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 24.08.2021.
//

import UIKit

class VideoListVC: UIViewController {

    //MARK: Properties

    var tableView = UITableView()
    let videoListViewModel = VideoListViewModel()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Settings", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        let frameSize = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 60, height: 40))
        button.frame = frameSize
    
        button.addTarget(self, action: #selector(handleSettingsTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingsButton)
        
        themeManager.register(observer: self)
        configureTableView()
        videoListViewModel.fetchVideos(pageIndex: videoListViewModel.pageIndex, pageSize: videoListViewModel.pageSize)
    }
    
    
    //MARK: Helpers
    
    func configureTableView() {
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        setTableViewDelegates()
        tableView.backgroundColor = themeManager.theme.background
        tableView.pin(to: view)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            tableView.rowHeight = 150
        }else if UIDevice.current.userInterfaceIdiom == .pad {
            tableView.rowHeight = self.view.frame.size.height / 10
        }
        
        tableView.register(VideoCell.self, forCellReuseIdentifier: Constants.videoCell)
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        videoListViewModel.delegate = self
    }

    
    @objc func handleSettingsTapped(sender: UIBarButtonItem) {
        let controller = SettingsVC()
        navigationController?.pushViewController(controller, animated: true)
    }
}

    //Tableview Delegates

extension VideoListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoListViewModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.videoCell) as! VideoCell
        let videoInfo = videoListViewModel.videos[indexPath.row]
        
        switch themeManager.theme.type {
        case .dark:
            cell.set(with: videoInfo)
            cell.contentView.backgroundColor = themeManager.theme.background
            cell.containerView.backgroundColor = themeManager.theme.portalCellBackground
            cell.videoTitleLabel.textColor = .white
        case .light:
            cell.set(with: videoInfo)
            cell.contentView.backgroundColor = themeManager.theme.background
            
        }
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            videoListViewModel.pageIndex += 1
            videoListViewModel.fetchVideos(pageIndex: videoListViewModel.pageIndex, pageSize: videoListViewModel.pageSize)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = VideoDetailsVC()
        controller.getTitle = videoListViewModel.videos[indexPath.row].title
        controller.getTitleBackgroundColor = videoListViewModel.videos[indexPath.row].colorAvarage
        controller.getTitleLabelColor = videoListViewModel.videos[indexPath.row].textColor
        controller.getShortContent = videoListViewModel.videos[indexPath.row].shortContent
        controller.getDate = videoListViewModel.videos[indexPath.row].createDateWellFormed
        controller.getCategory = videoListViewModel.videos[indexPath.row].category.name
        controller.getMp3URL = videoListViewModel.videos[indexPath.row].videos[2].value
        controller.getSDURL = videoListViewModel.videos[indexPath.row].videos[3].value
        controller.getHDURL = videoListViewModel.videos[indexPath.row].videos[4].value
        controller.getFHDURL = videoListViewModel.videos[indexPath.row].videos[5].value
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

    //ViewModel Delegate

extension VideoListVC: VideoListViewModelDelegate {
    func refreshTableView( ) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension VideoListVC: Themeable {
    func apply(theme: Theme) {
        tableView.backgroundColor = theme.background
        settingsButton.setTitleColor(theme.textColor, for: .normal)
        
        navigationItem.scrollEdgeAppearance = GeneralAppearance.navigationbarAppearance()
        navigationItem.standardAppearance = GeneralAppearance.navigationbarAppearance()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
