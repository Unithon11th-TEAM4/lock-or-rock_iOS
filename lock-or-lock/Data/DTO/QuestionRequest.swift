//
//  QuestionRequest.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

// 퀴즈 결과 저장
struct QuestionListRequest: Codable {
    let memberId: Int
    let answers: [QuestionRequest]
    
    enum CodingKeys: String, CodingKey {
        case memberId = "member_id"
        case answers
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

// 퀴즈 결과 reponse
struct ReportReponse: Codable {
    let code: Int
    let data: ReportDataResponse
}

struct ReportDataResponse: Codable {
    let nickname: String
    let memberPersonality: [memberPersonalityResponse]
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case memberPersonality = "member_personality"
    }
}

struct memberPersonalityResponse: Codable {
    let content: String
    let verb: String?
}
