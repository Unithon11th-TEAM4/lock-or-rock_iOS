//
//  NameService.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation
import Moya

public enum NameService {
    case saveName(nickname: String)
}

extension NameService: TargetType {
    public var baseURL: URL { return URL(string: BaseAPI.shared.baseURL)! }
    
    public var path: String {
        switch self {
        case .saveName(nickname: let nickname):
            return "/member"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .saveName:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .saveName(nickname: let nickname):
            let param: [String: Any] = [
                "nickname": nickname
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

