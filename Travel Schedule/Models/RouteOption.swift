//
//  RouteOption.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import Foundation

struct RouteOption: Identifiable, Hashable, Sendable {
    let id: UUID
    let carrier: Carrier
    let routeDate: Date
    let departureTime: Date
    let arrivalTime: Date
    let duration: String
    let transferDescription: String?
}


