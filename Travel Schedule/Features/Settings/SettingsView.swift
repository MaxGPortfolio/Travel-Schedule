//
//  SettingsView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct SettingsView: View {
    //    @State private var errorType: NetworkErrorType = .server
    @Binding var isDarkMode: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle("Темная тема", isOn: $isDarkMode)
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

// Раньше была заглушка с показом сетевой ошибки, пока не используется

//#Preview("Server") {
//    NetworkErrorView(errorType: .server)
//}
//
//#Preview("No Internet") {
//    NetworkErrorView(errorType: .noInternet)
//}


//NetworkErrorView(errorType: errorType)
//    .onAppear {
//        errorType = NetworkErrorType.allCases.randomElement() ?? .server
//    }
