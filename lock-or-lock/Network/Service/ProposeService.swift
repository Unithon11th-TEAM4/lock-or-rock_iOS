//
//  ProposeService.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import Foundation
import Moya

enum ProposeService {
    case addQuestions(proposedQuestion: ProposedQuestion)
}

extension ProposeService: TargetType {
    public var baseURL: URL { return URL(string: BaseAPI.shared.baseURL)! }
    
    public var path: String {
        switch self {
        case .addQuestions:
            return "/proposed-question"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addQuestions:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .addQuestions(let proposedQuestion):
            return .requestJSONEncodable(proposedQuestion)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
