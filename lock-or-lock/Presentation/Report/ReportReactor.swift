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
        case likeCount(Int)
    }
    
    enum Mutation {
        case likeCount(Int)
    }
    
    struct State {
        var reportReponse: ReportReponse
        var likeCount: Int?
    }
    
    var initialState: State
    let rankingUseCase: RankingUseCase
    
    init(reportReponse: ReportReponse, rankingUseCase: RankingUseCase) {
        self.initialState = State(reportReponse: reportReponse)
        self.rankingUseCase = rankingUseCase
        
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .likeCount(let likeCount):
            return .just(.likeCount(likeCount))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        case .likeCount(let likeCount):
            newState.likeCount = likeCount
        }
        
        return newState
    }
    
    @MainActor
    func likePost() {
        Task {
            let memberId = TokenManager.shared.getIntUserId()
            let resultLike = try await self.rankingUseCase.postLike(memberId: memberId)
            action.onNext(.likeCount(resultLike.data.likeCount))
        }
    }
}
