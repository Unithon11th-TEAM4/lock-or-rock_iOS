//
//  QuestionRepositoryInterface.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

protocol QuestionRepositoryInterface {
    func getQuestions() async throws -> QuestionResponse
    func postQuestions(questionRequest: QuestionRequest) async throws -> ReportReponse
}
