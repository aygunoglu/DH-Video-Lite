//
//  VideosAPI.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 15.09.2021.
//

import Moya

enum VideosAPI {
    case getVideos(pageIndex: Int, pageSize: Int)
}

extension VideosAPI: BaseService {
    var baseURL: URL {
        return URL(string: "https://api.donanimhaber.com/dev/and/api")!
    }
    
    var path: String {
        switch self {
        case .getVideos:
            return "/videos"
        }
    }
    
    var method: Method {
        switch self {
        case .getVideos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getVideos(let pageIndex, let pageSize):
            return .requestParameters(parameters: ["pageIndex": pageIndex, "pageSize": pageSize], encoding: URLEncoding.default)
        }
    }
    
    
}
