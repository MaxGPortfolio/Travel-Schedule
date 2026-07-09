//
//  AllStationsService.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func fetchAllStations() async throws -> AllStations
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func fetchAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey,
            format: .json
        ))
        
        let responseBody = try response.ok.body.html
        let limit = 50 * 1024 * 1024
        let data = try await Data(collecting: responseBody, upTo: limit)
        
        return try JSONDecoder().decode(AllStations.self, from: data)
    }
}
