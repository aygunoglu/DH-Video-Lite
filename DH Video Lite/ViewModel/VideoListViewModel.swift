//
//  VideoListViewModel.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 25.08.2021.
//

import Foundation

protocol VideoListViewModelDelegate: AnyObject {
    func refreshTableView()
}

final class VideoListViewModel {
    
    var pageIndex = 0
    var pageSize = 20
    var videos = [VideoInfo]()
    weak var delegate: VideoListViewModelDelegate?
    
    func fetchVideos(pageIndex: Int, pageSize: Int) {
        NetworkManager.shared.fetchVideos(pageIndex: pageIndex, pageSize: pageSize) { videos, error in
            if let safeVideos = videos {
                self.videos = safeVideos
            }
            self.delegate?.refreshTableView()
        }
    }
    
}
