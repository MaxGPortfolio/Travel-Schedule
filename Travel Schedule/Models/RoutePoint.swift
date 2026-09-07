//
//  RoutePoint.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

struct RoutePoint: Hashable, Sendable {
    let city: String
    let station: String
    let stationCode: String
    
    var displayTitle: String {
            "\(city) (\(station))"
        }
}
