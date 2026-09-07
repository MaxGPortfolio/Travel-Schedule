//
//  NetworkClient.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

actor NetworkClient {
    private let client: Client
    private let apiKey: String

    init(apiKey: String) throws {
        let serverURL = try Servers.Server1.url()

        client = Client(
            serverURL: serverURL,
            transport: URLSessionTransport()
        )
        self.apiKey = apiKey
    }

    func fetchAllStations() async throws -> AllStations {
        let service = AllStationsService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchAllStations()
    }

    func fetchCarrierInfo(code: Int) async throws -> CarrierInfo {
        let service = CarrierInfoService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchCarrierInfo(code: code)
    }

    func fetchCopyright() async throws -> Copyright {
        let service = CopyrightService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchCopyright()
    }

    func fetchNearestSettlement(
        latitude: Double,
        longitude: Double
    ) async throws -> NearestSettlement {
        let service = NearestSettlementService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchNearestSettlement(
            lat: latitude,
            lng: longitude
        )
    }

    func fetchNearestStations(
        latitude: Double,
        longitude: Double,
        distance: Int
    ) async throws -> NearestStations {
        let service = NearestStationsService(
            client: client,
            apikey: apiKey
        )

        return try await service.getNearestStations(
            lat: latitude,
            lng: longitude,
            distance: distance
        )
    }

    func searchRoutes(
        from originCode: String,
        to destinationCode: String
    ) async throws -> SearchRoutes {
        let service = SearchRoutesService(
            client: client,
            apikey: apiKey
        )

        return try await service.searchRoutes(
            from: originCode,
            to: destinationCode
        )
    }

    func fetchStationSchedule(
        stationCode: String
    ) async throws -> StationSchedule {
        let service = StationScheduleService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchStationSchedule(
            station: stationCode
        )
    }

    func fetchThreadStations(
        uid: String
    ) async throws -> ThreadStations {
        let service = ThreadStationsService(
            client: client,
            apikey: apiKey
        )

        return try await service.fetchThreadStations(uid: uid)
    }
}
