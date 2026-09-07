//
//  RoutesSearchService.swift
//  Travel Schedule
//
//  Created by Максим on 08.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchRoutes = Components.Schemas.SearchResponse

protocol SearchRoutesServiceProtocol {
    func searchRoutes(
        from: String,
        to: String
    ) async throws -> SearchRoutes
}

final class SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func searchRoutes(
        from originCode: String,
        to destinationCode: String
    ) async throws -> SearchRoutes {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"

        let currentDate = formatter.string(from: Date())

        let response = try await client.searchRoutes(
            query: .init(
                apikey: apikey,
                from: originCode,
                to: destinationCode,
                date: currentDate,
                transfers: true
            )
        )

        return try response.ok.body.json
    }
}

