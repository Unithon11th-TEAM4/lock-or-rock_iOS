//
//  RankingUseCase.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation

protocol RankingUseCase {
    func postLike(memberId: Int) async throws -> LikeCountResponse
}

struct RankingUseCaseImp: RankingUseCase {
    private(set) var rankingRepository: RankingRepositoryInterface
    
    func postLike(memberId: Int) async throws -> LikeCountResponse {
        try await rankingRepository.postLike(memberId: memberId)
    }
}
