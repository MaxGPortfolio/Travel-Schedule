//
//  ContentView.swift
//  Travel Schedule
//
//  Created by Максим on 24.06.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            APITester.testFetchStations()
            APITester.testSearchRoutes()
            APITester.testStationSchedule()
            APITester.testAllStations()
            APITester.testCarrierInfo()
            APITester.testCopyright()
            APITester.testNearestSettlement()
            APITester.testThreadStations()
        }
    }
}

#Preview {
    ContentView()
}

