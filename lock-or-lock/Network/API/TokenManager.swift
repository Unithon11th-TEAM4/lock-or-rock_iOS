//
//  TokenManager.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

struct TokenManager {
    
    static let shared = TokenManager()
    
    func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: "userId")
    }
    
    func saveUserId(userId: Int) {
        UserDefaults.standard.set("\(userId)", forKey: "userId")
    }
    
    func resetUserToken() {
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func getIntUserId() -> Int {
        if let id = getUserId() {
            return Int(id) ?? 0
        } else {
            return 0
        }
    }
}
