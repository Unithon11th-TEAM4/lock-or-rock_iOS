//
//  MoyaProvider+Extensions.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import Foundation
import Moya

public extension MoyaProvider {
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
}

public func decode<T: Decodable>(data: Data) throws -> T {
    try JSONDecoder().decode(T.self, from: data)
}

