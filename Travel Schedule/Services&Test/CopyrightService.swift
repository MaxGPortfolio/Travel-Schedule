//
//  CopyrightService.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func fetchCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func fetchCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        
        return try response.ok.body.json
    }
}
