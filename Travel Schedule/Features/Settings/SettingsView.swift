//
//  SettingsView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var errorType: NetworkErrorType = .server

    var body: some View {
        NetworkErrorView(errorType: errorType)
            .onAppear {
                errorType = NetworkErrorType.allCases.randomElement() ?? .server
            }
    }
}

#Preview("Server") {
    NetworkErrorView(errorType: .server)
}

#Preview("No Internet") {
    NetworkErrorView(errorType: .noInternet)
}
