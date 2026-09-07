//
//  SettingsView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    
    init(isDarkMode: Binding<Bool>) {
        _viewModel = StateObject(
            wrappedValue: SettingsViewModel(
                isDarkMode: isDarkMode.wrappedValue,
                onThemeChanged: { newValue in
                    isDarkMode.wrappedValue = newValue
                }
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle("Темная тема", isOn: $viewModel.isDarkMode)
                .frame(height: 60)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlackDay)
            
            NavigationLink {
                UserAgreementView()
            } label: {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.primary)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 60,
                alignment: .leading
            )
            
            Spacer()
            
            VStack(spacing: 16) {
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                Text("Версия 1.0 (beta)")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
            }
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 16)
        .background(Color.ypWhiteDay.ignoresSafeArea())
    }
}

#Preview {
    SettingsView(isDarkMode: .constant(true))
}
