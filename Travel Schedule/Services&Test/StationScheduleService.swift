//
//  StationScheduleService.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.StationScheduleResponse

protocol StationScheduleServiceProtocol {
    func fetchStationSchedule(station: String) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func fetchStationSchedule(station code: String) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: code
        ))
        
        return try response.ok.body.json
    }
}
