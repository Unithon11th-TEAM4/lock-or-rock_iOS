//
//  ProposedQuestion.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import Foundation

struct ProposedQuestion: Codable {
    let memberId: Int
    let questionContent: String
    let questionAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case memberId = "member_id"
        case questionContent = "question_content"
        case questionAnswers = "question_answers"
    }
}
