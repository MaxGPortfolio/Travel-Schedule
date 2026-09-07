//
//  UserAgreementViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    @Published private(set) var agreementText = AttributedString()
    @Published private(set) var isLoading = true

    private var hasLoaded = false

    func loadAgreement() {
        guard !hasLoaded else { return }

        hasLoaded = true

        defer {
            isLoading = false
        }

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
            agreementText = AttributedString(
                "Не удалось загрузить пользовательское соглашение"
            )
            return
        }

        var result = AttributedString()

        for line in markdown.components(separatedBy: "\n") {
            let formattedLine =
                (try? AttributedString(markdown: line))
                ?? AttributedString(line)

            result.append(formattedLine)
            result.append(AttributedString("\n"))
        }

        agreementText = result
    }
}
