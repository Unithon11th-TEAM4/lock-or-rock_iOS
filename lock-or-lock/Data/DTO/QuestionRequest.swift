//
//  QuestionRequest.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

struct QuestionListRequest: Decodable {
    let questionList: [QuestionRequest]
}

struct QuestionRequest: Decodable {
    let questionNum: Int
    let answerNum: Int
}
