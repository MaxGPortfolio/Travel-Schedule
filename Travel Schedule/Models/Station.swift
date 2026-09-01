//
//  Station.swift
//  Travel Schedule
//
//  Created by Максим on 04.08.2026.
//

struct Station: Identifiable, Hashable {
    let code: String
    let title: String
    
    var id: String { code }
}
