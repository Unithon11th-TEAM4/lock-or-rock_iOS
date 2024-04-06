//
//  QuestionRepository.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation
import Moya

struct QuestionRepository: QuestionRepositoryInterface {
    let provider = MoyaProvider<QuestionService>(plugins: [NetworkLogger()])
    
    func getQuestions() async throws -> QuestionResponse {
        let result = await provider.request(.getQuestions)
        
        switch result {
        case .success(let response):
            return try decode(data: response.data)
        case .failure(let error):
            throw error
        }
    }
    
    func postQuestions(questionRequest: QuestionRequest) async throws -> ReportReponse {
        let result = await provider.request(.postQuestions(questionRequest: questionRequest))
        
        switch result {
        case .success(let response):
            return try decode(data: response.data)
        case .failure(let error):
            throw error
        }
    }
}
