//
//  UserAgreementView.swift
//  Travel Schedule
//
//  Created by Максим on 01.09.2026.
//

import Foundation
import SwiftUI

struct UserAgreementView: View {
    @StateObject private var viewModel = UserAgreementViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    Text(viewModel.agreementText)
                        .font(.system(size: 15))
                        .lineSpacing(6)
                        .foregroundStyle(.ypBlackDay)
                        .textSelection(.enabled)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 24)
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .task {
            viewModel.loadAgreement()
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
