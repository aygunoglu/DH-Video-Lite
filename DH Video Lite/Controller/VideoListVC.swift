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
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        configureTableView()
        videoListViewModel.fetchVideos(pageNumber: videoListViewModel.pageNumber)
    }
    
    
    //MARK: Helpers
    
    func configureTableView() {

//        tableView.estimatedRowHeight = 2000.0
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        setTableViewDelegates()
        tableView.backgroundColor = Constants.defaultBackgroundColor
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
        cell.frame.size.width = tableView.frame.size.width
        let videoInfo = videoListViewModel.videos[indexPath.row]
        cell.set(with: videoInfo)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            videoListViewModel.pageNumber += 1
            videoListViewModel.fetchVideos(pageNumber: videoListViewModel.pageNumber)
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

