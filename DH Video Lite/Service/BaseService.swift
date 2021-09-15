//
//  BaseService.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 15.09.2021.
//

import Moya

protocol BaseService: TargetType { }

extension BaseService {
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
