//
//  QuestionReactor.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation
import RxSwift
import ReactorKit

class QuestionReactor: Reactor {
    
    enum Action {
        case answerNumber(QuestionButtonType)
        case appendAnswer(QuestionRequest)
        case questionsResponse([QuestionResponse])
    }
    
    enum Mutation {
        case answerNumber(QuestionButtonType)
        case appendAnswer(QuestionRequest)
        case questionsResponse([QuestionResponse])
    }
    
    struct State {
        var currentAnswerNum: QuestionButtonType?
        var currentQuestionNum: Int = 1
        var answerList: [QuestionRequest] = []
        var questionsResponse: [QuestionResponse] = []
    }
    
    var initialState: State
    let questionUseCase: QuestionUseCase
    
    init(questionUseCase: QuestionUseCase) {
        self.initialState = State()
        self.questionUseCase = questionUseCase
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .answerNumber(let answerNum):
            return .just(.answerNumber(answerNum))
        case .appendAnswer(let answer):
            return .just(.appendAnswer(answer))
        case .questionsResponse(let questions):
            return .just(.questionsResponse(questions))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .answerNumber(let answerNum):
            newState.currentAnswerNum = answerNum
        case .appendAnswer(let answer):
            newState.answerList.append(answer)
            if newState.currentQuestionNum == 5 {
                break
            }
            newState.currentQuestionNum += 1
            newState.currentAnswerNum = nil
        case .questionsResponse(let questions):
            newState.questionsResponse = questions
        }
        
        return newState
    }
    
    @MainActor
    func fetchQuestions() {
        Task {
            let questionsDataResponse = try await self.questionUseCase.getQuestions()
            action.onNext(.questionsResponse(questionsDataResponse.data))
        }
    }
    
    func appendAnswer() {
        let currentQuestionNum = currentState.currentQuestionNum
        let questionsResponse = currentState.questionsResponse
        guard let currentAnswerNum = currentState.currentAnswerNum else { return }
        
        if currentQuestionNum > 5 {
            return
        }
        
        switch currentAnswerNum {
        case .leftTop:
            action.onNext(.appendAnswer(.init(
                questionId: questionsResponse[currentQuestionNum-1].questionId,
                answerId: questionsResponse[currentQuestionNum-1].answers[0].answerId))
            )
        case .rightTop:
            action.onNext(.appendAnswer(.init(
                questionId: questionsResponse[currentQuestionNum-1].questionId,
                answerId: questionsResponse[currentQuestionNum-1].answers[1].answerId))
            )
        case .leftBottom:
            action.onNext(.appendAnswer(.init(
                questionId: questionsResponse[currentQuestionNum-1].questionId,
                answerId: questionsResponse[currentQuestionNum-1].answers[2].answerId))
            )
        case .rightBottom:
            action.onNext(.appendAnswer(.init(
                questionId: questionsResponse[currentQuestionNum-1].questionId,
                answerId: questionsResponse[currentQuestionNum-1].answers[3].answerId))
            )
        }
    }
    
    // TODO: 퀴즈 제출 API 연결
    @MainActor
    func postAnswer() {
        appendAnswer()
        
        Task {
            do {
                let currentQuestionRequest = currentState.answerList
                let postQuestionresult = try await questionUseCase.postQuestions(questionRequest: currentQuestionRequest)
                print(postQuestionresult)
            } catch {
                print("post error")
            }
        }
        
    }
}
