//
//  RoutesSearchService.swift
//  Travel Schedule
//
//  Created by Максим on 08.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchRoutes = Components.Schemas.SearchResponse

protocol SearchRoutesServiceProtocol {
    func searchRoutes(from: String, to: String) async throws -> SearchRoutes
}

final class SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func searchRoutes(from originCode: String, to destinationCode: String) async throws -> SearchRoutes {
        let response = try await client.searchRoutes(query: .init(
            apikey: apikey,
            from: originCode,
            to: destinationCode
        ))
        
        return try response.ok.body.json
    }
}

