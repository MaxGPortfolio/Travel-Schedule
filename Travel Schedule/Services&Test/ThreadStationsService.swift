//
//  ThreadStationsService.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStations = Components.Schemas.ThreadStationsResponse

protocol ThreadStationsServiceProtocol {
    func fetchThreadStations(uid: String) async throws -> ThreadStations
}


final class ThreadStationsService: ThreadStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func fetchThreadStations(uid thread: String) async throws -> ThreadStations {
        let response = try await client.getThreadStations(query: .init(
            apikey: apikey,
            uid: thread
        ))
        
        return try response.ok.body.json
    }
}
