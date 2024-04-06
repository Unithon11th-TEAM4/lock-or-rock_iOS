//
//  QuestionUseCase.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation

protocol QuestionUseCase {
    func getQuestions() async throws -> SearchQuestionResponse
    func postQuestions(questionRequest: [QuestionRequest]) async throws -> ReportReponse
}

struct QuestionUseCaseImp: QuestionUseCase {
    private(set) var questionRepository: QuestionRepositoryInterface
    
    func getQuestions() async throws -> SearchQuestionResponse {
        try await questionRepository.getQuestions()
    }
    
    func postQuestions(questionRequest: [QuestionRequest]) async throws -> ReportReponse {
        try await questionRepository.postQuestions(questionRequest: questionRequest)
    }
}
