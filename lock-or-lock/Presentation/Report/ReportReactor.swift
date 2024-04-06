//
//  ReportReactor.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation
import RxSwift
import ReactorKit

class ReportReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var reportReponse: ReportReponse
    }
    
    var initialState: State
    
    
    init(reportReponse: ReportReponse) {
        self.initialState = State(reportReponse: reportReponse)
        
        
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
