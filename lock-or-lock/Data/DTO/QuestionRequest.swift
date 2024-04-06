//
//  QuestionRequest.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

// 퀴즈 결과 저장
struct QuestionListRequest: Codable {
    let memeberId: Int
    let quizResult: [QuestionRequest]
    
    enum CodingKeys: String, CodingKey {
        case memeberId
        case quizResult = "quiz_result"
    }
}

struct QuestionRequest: Codable {
    let questionId: Int
    let answerId: Int
    
    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case answerId = "answer_id"
    }
}

// 한줄평
struct ReportReponse: Codable {
    let memberPersonality: String
    
    enum CodingKeys: String, CodingKey {
        case memberPersonality = "member_personality"
    }
}
