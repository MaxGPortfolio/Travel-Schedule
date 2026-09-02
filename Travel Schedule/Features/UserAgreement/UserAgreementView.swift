//
//  UserAgreementView.swift
//  Travel Schedule
//
//  Created by Максим on 01.09.2026.
//

import Foundation
import SwiftUI

struct UserAgreementView: View {
    private static let agreementText: AttributedString = {
        guard
            let url = Bundle.main.url(
                forResource: "UserAgreement",
                withExtension: "md"
            ),
            let markdown = try? String(
                contentsOf: url,
                encoding: .utf8
            )
        else {
            return AttributedString(
                "Не удалось загрузить пользовательское соглашение"
            )
        }

        var result = AttributedString()

        for line in markdown.components(separatedBy: "\n") {
            let formattedLine =
                (try? AttributedString(markdown: line))
                ?? AttributedString(line)

            result.append(formattedLine)
            result.append(AttributedString("\n"))
        }

        return result
    }()

    var body: some View {
        ScrollView {
            Text(Self.agreementText)
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
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
