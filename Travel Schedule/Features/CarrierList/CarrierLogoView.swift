//
//  CarrierLogoView.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import SwiftUI

struct CarrierLogoView: View {
    let logoName: String

    private var remoteURL: URL? {
        let normalizedLogoName: String

        if logoName.hasPrefix("//") {
            normalizedLogoName = "https:\(logoName)"
        } else {
            normalizedLogoName = logoName
        }

        guard
            let url = URL(string: normalizedLogoName),
            let scheme = url.scheme?.lowercased(),
            ["http", "https"].contains(scheme)
        else {
            return nil
        }

        return url
    }

    var body: some View {
        if let remoteURL {
            AsyncImage(url: remoteURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(logoName)
                .resizable()
                .scaledToFit()
        }
    }
}
