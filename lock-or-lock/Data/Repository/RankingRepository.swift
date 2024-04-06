//
//  RankingRepository.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/7/24.
//

import Foundation
import Moya

struct RankingRepository: RankingRepositoryInterface {
    let provider = MoyaProvider<RankingService>(plugins: [NetworkLogger()])
    
    func postLike(memberId: Int) async throws -> LikeCountResponse {
        let result = await provider.request(.like(memberId: memberId))
        
        switch result {
        case .success(let response):
            return try decode(data: response.data)
        case .failure(let error):
            throw error
        }
    }
}
