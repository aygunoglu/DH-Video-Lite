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
        button.theme_setTitleColor(GlobalPicker.textColor, forState: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
    
        let frameSize = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 60, height: 40))
        button.frame = frameSize
        button.setTitle("Settings", for: .normal)
    
        button.addTarget(self, action: #selector(handleSettingsTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        configureTableView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingsButton)
        videoListViewModel.fetchVideos(pageIndex: videoListViewModel.pageIndex, pageSize: videoListViewModel.pageSize)
        
        updateTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func handleSettingsTapped(sender: UIBarButtonItem) {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: Helpers
    
    func configureTableView() {

        tableView.theme_backgroundColor = GlobalPicker.backgroundColor
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        setTableViewDelegates()
        //tableView.backgroundColor = Constants.defaultBackgroundColor
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
}

    //Tableview Delegates

extension VideoListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoListViewModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.videoCell) as! VideoCell
        let videoInfo = videoListViewModel.videos[indexPath.row]
        cell.set(with: videoInfo)
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

extension VideoListVC {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }
        
        updateTheme()
    }
    
    private func updateTheme() {
        guard #available(iOS 12.0, *) else { return }
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            MyThemes.switchNight(isToNight: false)
        case .dark:
            MyThemes.switchNight(isToNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
}

