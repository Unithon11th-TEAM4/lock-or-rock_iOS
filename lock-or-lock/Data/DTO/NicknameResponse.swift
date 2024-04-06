//
//  NicknameResponse.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

struct NicknameResponse: Codable {
    let code: Int
    let data: NicknameDataResponse
}

struct NicknameDataResponse: Codable {
    let memberId: Int
    let isDuplicatedNickname: Bool
    
    enum CodingKeys: String, CodingKey {
        case memberId = "member_id"
        case isDuplicatedNickname = "is_duplicated_nickname"
    }
}
