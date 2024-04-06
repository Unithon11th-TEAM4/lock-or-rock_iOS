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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        }
        
        return newState
    }
}
