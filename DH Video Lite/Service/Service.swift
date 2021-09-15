//
//  Service.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 25.08.2021.
//

import Foundation
import Moya

class Service {
    static let shared = Service()
    var videos = [VideoInfo]()
    
    func fetchVideo(page: Int, completion: @escaping ([VideoInfo]) -> ()) {
        guard let url = URL(string: "https://api.donanimhaber.com/dev/and/api/videos?pageIndex=\(page)&pageSize=20") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let videoData = try! jsonDecoder.decode(Video.self, from: data)
                self.videos.append(contentsOf: videoData.data.newest.data)
                completion(self.videos)
            }
        }
        task.resume()
    }
    
}
