//
//  RoutePointKind.swift
//  Travel Schedule
//
//  Created by Максим on 29.07.2026.
//

enum RoutePointKind: Hashable, Identifiable, Sendable {
    case departure
    case destination

    var id: Self {
        self
    }
}
