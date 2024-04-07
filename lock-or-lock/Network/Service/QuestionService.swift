//
//  QuestionService.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation
import Moya

enum QuestionService {
    case getQuestions
    case postQuestions(questionRequest: QuestionListRequest)
}

extension QuestionService: TargetType {
    public var baseURL: URL { return URL(string: BaseAPI.shared.baseURL)! }
    
    public var path: String {
        switch self {
        case .getQuestions, .postQuestions:
            return "/questions"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getQuestions:
            return .get
        case .postQuestions:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .getQuestions:
            return .requestPlain
        case .postQuestions(let questionRequest):
            return .requestJSONEncodable(questionRequest)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
