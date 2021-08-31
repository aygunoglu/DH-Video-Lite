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
    
    var pageNumber = 0
    var videos = [VideoInfo]()
    weak var delegate: VideoListViewModelDelegate?
    
    func fetchVideos(pageNumber: Int) {
        Service.shared.fetchVideo(page: pageNumber) { videos in
            self.videos = videos
            self.delegate?.refreshTableView()
        }
    }
    
    
}
