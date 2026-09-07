//
//  CitySelectionViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import SwiftUI

import Combine
import Foundation

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var cities: [City] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorType: NetworkErrorType?
    
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    var filteredCities: [City] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return cities
        }

        return cities.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }
    
    func loadCities() async {
        guard cities.isEmpty else { return }

        isLoading = true
        errorType = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await networkClient.fetchAllStations()
            cities = makeCities(from: response)
        } catch is CancellationError {
            return
        } catch {
            errorType = NetworkErrorType.from(error)
        }
    }
    
    private func makeCities(from response: AllStations) -> [City] {
        let settlements = response.countries?
            .flatMap { $0.regions ?? [] }
            .flatMap { $0.settlements ?? [] } ?? []

        return settlements.compactMap { settlement in
            guard
                let cityTitle = settlement.title,
                !cityTitle.isEmpty
            else {
                return nil
            }

            let stations: [Station] = (settlement.stations ?? []).compactMap {
                apiStation in

                let stationCode = apiStation.codes?.yandex_code
                    ?? apiStation.codes?.yandex
                    ?? apiStation.code

                guard
                    let stationCode,
                    let stationTitle = apiStation.title,
                    !stationTitle.isEmpty
                else {
                    return nil
                }

                return Station(
                    code: stationCode,
                    title: makeStationTitle(
                        stationTitle,
                        cityTitle: cityTitle
                    )
                )
            }

            guard !stations.isEmpty else {
                return nil
            }

            return City(
                id: settlement.codes?.yandex_code ?? cityTitle,
                title: cityTitle,
                stations: stations
            )
        }
        .sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title)
                == .orderedAscending
        }
    }
    
    private func makeStationTitle(
        _ stationTitle: String,
        cityTitle: String
    ) -> String {
        let prefix = "\(cityTitle) ("

        guard
            stationTitle.hasPrefix(prefix),
            stationTitle.hasSuffix(")")
        else {
            return stationTitle
        }

        return String(
            stationTitle
                .dropFirst(prefix.count)
                .dropLast()
        )
    }
}
