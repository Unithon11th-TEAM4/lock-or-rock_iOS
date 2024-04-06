//
//  RankingRepositoryInterface.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

protocol RankingRepositoryInterface {
    func postLike(memberId: Int) async throws -> LikeCountResponse
}
