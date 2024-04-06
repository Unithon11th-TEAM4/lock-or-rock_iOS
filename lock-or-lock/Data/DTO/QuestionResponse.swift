//
//  QuestionResponse.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation

// 퀴즈 조회
struct SearchQuestionResponse: Codable {
    let code: Int
    let data: [QuestionResponse]
}

struct QuestionResponse: Codable {
    let questionId: Int
    let content: String
    let answerId: Int
    let answers: [QuestionAnswerResponse]
    let commentary: String?
    
    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case content
        case answerId = "answer_id"
        case answers
        case commentary
    }
}

struct QuestionAnswerResponse: Codable {
    let answerId: Int
    let content: String
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case answerId = "answer_id"
        case content
        case url
    }
}

