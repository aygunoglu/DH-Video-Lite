//
//  NetworkManager.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 15.09.2021.
//

import Moya

protocol Networkable {
    associatedtype DataType
    
    var videos: [DataType] { get set }
    var provider: MoyaProvider<VideosAPI> { get }
    func fetchVideos(pageIndex: Int, pageSize: Int, completion: @escaping ([VideoInfo]?, Error?) -> ())
}

class NetworkManager: Networkable {
    static let shared = NetworkManager()
    var provider = MoyaProvider<VideosAPI>()
    var videos = [VideoInfo]()
    
    func fetchVideos(pageIndex: Int, pageSize: Int, completion: @escaping ([VideoInfo]?, Error?) -> ()) {
        provider.request(.getVideos(pageIndex: pageIndex, pageSize: pageSize)) { (response) in
            switch response {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let videoData = try decoder.decode(Video.self, from: value.data)
                    self.videos.append(contentsOf: videoData.data.newest.data)
                    completion(self.videos, nil)
                }catch let error {
                    completion(nil, error)
                }
            }
        }
    }

}
