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
    }
    
    enum Mutation {
        case answerNumber(QuestionButtonType)
        case appendAnswer(QuestionRequest)
    }
    
    struct State {
        var currentAnswerNum: QuestionButtonType?
        var currentQuestionNum: Int = 1
        var answerList: [QuestionRequest] = []
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
        }
        
        return newState
    }
    
    @MainActor
    func fetchQuestions() {
        Task {
            let questions = try await questionUseCase.getQuestions()
        }
    }
    
    func appendAnswer() {
        let currentQuestionNum = currentState.currentQuestionNum
        guard let currentAnswerNum = currentState.currentAnswerNum else { return }
        
        if currentQuestionNum > 5 {
            return
        }
        
        switch currentAnswerNum {
        case .leftTop:
            action.onNext(.appendAnswer(.init(questionId: currentQuestionNum, answerId: 0)))
        case .rightTop:
            action.onNext(.appendAnswer(.init(questionId: currentQuestionNum, answerId: 1)))
        case .leftBottom:
            action.onNext(.appendAnswer(.init(questionId: currentQuestionNum, answerId: 2)))
        case .rightBottom:
            action.onNext(.appendAnswer(.init(questionId: currentQuestionNum, answerId: 3)))
        }
    }
    
    // TODO: 퀴즈 제출 API 연결
    func postAnswer() {
        appendAnswer()
        print("5개 완료 - \(currentState.answerList)")
    }
}
