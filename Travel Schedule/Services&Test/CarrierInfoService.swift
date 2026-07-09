//
//  CarrierInfoService.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func fetchCarrierInfo(code: Int) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func fetchCarrierInfo(code: Int) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code
        ))
        
        return try response.ok.body.json
    }
}
