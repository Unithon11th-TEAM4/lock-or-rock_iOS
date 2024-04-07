//
//  RankingResponse.swift
//  lock-or-lock
//
//  Created by 임수진 on 4/7/24.
//

import Foundation

struct RankingResponse: Codable {
    let code: Int
    let data: RankingDto
}

struct RankingDto: Codable {
    let leaderboards: [Leaderboard]
}

struct Leaderboard: Codable {
    let rankNo: Int
    let memberId: Int
    let nickname: String
    let likeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case rankNo = "rank_no"
        case memberId = "member_id"
        case nickname
        case likeCount = "like_count"
    }
}

struct LikeCountResponse: Codable {
    let code: Int
    let data: LikeCountDataResponse
}

struct LikeCountDataResponse: Codable {
    let likeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case likeCount = "like_count"
    }
}
