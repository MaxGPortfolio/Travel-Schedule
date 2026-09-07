//
//  SettingsViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            onThemeChanged(isDarkMode)
        }
    }

    private let onThemeChanged: (Bool) -> Void

    init(
        isDarkMode: Bool,
        onThemeChanged: @escaping (Bool) -> Void
    ) {
        self.isDarkMode = isDarkMode
        self.onThemeChanged = onThemeChanged
    }
}
