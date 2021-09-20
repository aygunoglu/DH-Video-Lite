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
    
    
    let themeSwitch = UISwitch()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        themeManager.register(observer: self)
        configureTableView()
        rightNavButton()
        videoListViewModel.fetchVideos(pageIndex: videoListViewModel.pageIndex, pageSize: videoListViewModel.pageSize)
    }
    
    
    //MARK: Helpers
    
    func configureTableView() {
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        setTableViewDelegates()
        tableView.backgroundColor = themeManager.theme.portalListBackgroundColor
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
        
        switch themeManager.theme.type {
        case .dark:
            cell.set(with: videoInfo)
            cell.contentView.backgroundColor = themeManager.theme.portalListBackgroundColor
            cell.containerView.backgroundColor = themeManager.theme.tableViewCellBackgroundColor
            cell.videoTitleLabel.textColor = .white
        case .light:
            cell.set(with: videoInfo)
            cell.contentView.backgroundColor = themeManager.theme.portalListBackgroundColor
            
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
    
    func rightNavButton(){

        let frameSize = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30))
        themeSwitch.frame = frameSize

        themeSwitch.addTarget(self, action: #selector(didTap(switchView:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: themeSwitch)
    }
    
    @objc func didTap(switchView: UISwitch) {
        themeManager.toggleTheme()
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
        tableView.backgroundColor = theme.portalListBackgroundColor
        
        themeSwitch.onTintColor = theme.switchTintColor
        themeSwitch.isOn = theme == .dark
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
