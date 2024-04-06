//
//  RankingService.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import Foundation
import Moya

enum RankingService {
    case getRanking(memberId: Int)
    case like(memberId: Int)
}

extension RankingService: TargetType {
    public var baseURL: URL { return URL(string: BaseAPI.shared.baseURL)! }
    
    public var path: String {
        switch self {
        case .getRanking(memberId: let member_id):
            return "/leaderboards"
        case .like(memberId: let memberId):
            return "/leaderboard/like"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRanking:
            return .get
        case .like:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .getRanking(let memberId):
            return .requestParameters(parameters: ["member_id": memberId], encoding: URLEncoding.queryString)
        case .like:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
