//
//  StationSelectionViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class StationSelectionViewModel: ObservableObject {
    @Published var searchText = ""

    private let stations: [Station]

    init(stations: [Station]) {
        self.stations = stations
    }

    var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return stations
        }

        return stations.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }
}
