//
//  CarrierInfoViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    @Published private(set) var carrier: Carrier
    @Published private(set) var isLoading = false
    @Published private(set) var errorType: NetworkErrorType?

    private let networkClient: NetworkClient

    init(
        carrier: Carrier,
        networkClient: NetworkClient
    ) {
        self.carrier = carrier
        self.networkClient = networkClient
    }

    func loadCarrierInfo() async {
        guard let code = carrier.code else {
            return
        }

        isLoading = true
        errorType = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await networkClient.fetchCarrierInfo(
                code: code
            )

            guard let apiCarrier =
                response.carrier ?? response.carriers?.first
            else {
                errorType = .server
                return
            }

            carrier = Carrier(
                code: apiCarrier.code ?? code,
                name: apiCarrier.title ?? carrier.name,
                logoName: apiCarrier.logo ?? carrier.logoName,
                email: apiCarrier.email ?? carrier.email,
                phone: apiCarrier.phone ?? carrier.phone
            )
        } catch is CancellationError {
            return
        } catch {
            errorType = NetworkErrorType.from(error)
        }
    }
}
