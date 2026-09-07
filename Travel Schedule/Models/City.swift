//
//  City.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

struct City: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let stations: [Station]
}
