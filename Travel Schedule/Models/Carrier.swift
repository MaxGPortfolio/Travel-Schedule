//
//  Carrier.swift
//  Travel Schedule
//
//  Created by Максим on 31.08.2026.
//

import Foundation

struct Carrier: Hashable, Sendable {
    let code: Int?
    let name: String
    let logoName: String
    let email: String
    let phone: String

    init(
        code: Int? = nil,
        name: String,
        logoName: String,
        email: String,
        phone: String
    ) {
        self.code = code
        self.name = name
        self.logoName = logoName
        self.email = email
        self.phone = phone
    }
}
