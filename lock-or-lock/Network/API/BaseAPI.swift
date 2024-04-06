//
//  BaseAPI.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation

public final class BaseAPI {
    public static let shared = BaseAPI()
    private init() {}
    
    public let baseURL = "http://3.36.92.122:8080"
}
