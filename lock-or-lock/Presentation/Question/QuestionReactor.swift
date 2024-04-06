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
    }
    
    enum Mutation {
        case answerNumber(QuestionButtonType)
    }
    
    struct State {
        var currentAnswerNum: QuestionButtonType?
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .answerNumber(let answer):
            return .just(.answerNumber(answer))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .answerNumber(let answer):
            newState.currentAnswerNum = answer
        }
        
        return newState
    }
}
