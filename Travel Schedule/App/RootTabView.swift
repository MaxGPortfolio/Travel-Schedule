//
//  RootTabView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct RootTabView: View {
    @State private var selectedTab: AppTab = .schedule
    @State private var isDarkMode: Bool = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ScheduleView()
            }
            .tabItem {
                Image(
                    selectedTab == .schedule
                        ? .scheduleIconSelected
                        : .scheduleIcon
                )
                .renderingMode(.original)
            }
            .tag(AppTab.schedule)

            NavigationStack {
                SettingsView(isDarkMode: $isDarkMode)
            }
            .tabItem {
                Image(
                    selectedTab == .settings
                        ? .settingsIconSelected
                        : .settingsIcon
                )
                .renderingMode(.original)
            }
            .tag(AppTab.settings)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    RootTabView()
}
