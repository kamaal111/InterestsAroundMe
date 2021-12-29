//
//  XiphiasNet+extensions.swift
//  
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import XiphiasNet

extension XiphiasNet {
    static func request<T: Decodable>(
        from endpoint: Endpoint,
        headers: [String: String]?) async -> Result<Response<T>, XiphiasNet.Errors> {
            await withCheckedContinuation { continuation in
                XiphiasNet.request(from: endpoint.url, headers: headers) { result in
                    continuation.resume(returning: result)
                }
            }
        }
}
