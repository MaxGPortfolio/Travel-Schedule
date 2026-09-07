//
//  RouteFilters.swift
//  Travel Schedule
//
//  Created by Максим on 19.08.2026.
//

struct RouteFilters: Sendable {
    var selectedTimes: Set<DepartureTime>
    var showTransfers: Bool?
}
