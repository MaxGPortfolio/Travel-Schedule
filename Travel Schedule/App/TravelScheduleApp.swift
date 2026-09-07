//
//  Travel_ScheduleApp.swift
//  Travel Schedule
//
//  Created by Максим on 24.06.2026.
//

import SwiftUI

@main
struct Travel_ScheduleApp: App {
    private let networkClient: NetworkClient

    init() {
        do {
            networkClient = try NetworkClient(
                apiKey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
            )
        } catch {
            fatalError(
                "Failed to create NetworkClient: \(error)"
            )
        }
    }

    var body: some Scene {
        WindowGroup {
            RootTabView(networkClient: networkClient)
        }
    }
}
