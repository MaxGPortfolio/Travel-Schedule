//
//  RootTabView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct RootTabView: View {
    @State private var selectedTab: AppTab = .schedule
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ScheduleView()
            }
            .tabItem {
                Image(.scheduleIcon)
            }
            .tag(AppTab.schedule)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(.settingsIcon)
            }
            .tag(AppTab.settings)
        }
    }
}

#Preview {
    RootTabView()
}
