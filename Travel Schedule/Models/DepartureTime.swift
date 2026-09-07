//
//  DepartureTime.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import Foundation

enum DepartureTime: String, CaseIterable, Hashable, Sendable {
    case morning
    case day
    case evening
    case night
    
    var title: String {
        switch self {
        case .morning:
            "Утро 06:00 - 12:00"
        case .day:
            "День 12:00 - 18:00"
        case .evening:
            "Вечер 18:00 - 00:00"
        case .night:
            "Ночь 00:00 - 06:00"
        }
    }
    
    func contains(_ date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        
        switch self {
        case .morning:
            return (6..<12).contains(hour)
        case .day:
            return (12..<18).contains(hour)
        case .evening:
            return (18..<24).contains(hour)
        case .night:
            return (0..<6).contains(hour)
        }
    }
}
