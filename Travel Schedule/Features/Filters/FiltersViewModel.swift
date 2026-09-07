//
//  FiltersViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var filters: RouteFilters

    init(filters: RouteFilters) {
        self.filters = filters
    }

    var hasSelectedFilters: Bool {
        !filters.selectedTimes.isEmpty
            || filters.showTransfers != nil
    }

    func toggle(_ time: DepartureTime) {
        if filters.selectedTimes.contains(time) {
            filters.selectedTimes.remove(time)
        } else {
            filters.selectedTimes.insert(time)
        }
    }

    func selectTransfers(_ value: Bool) {
        filters.showTransfers = value
    }
}
