//
//  NetworkErrorView.swift
//  Travel Schedule
//
//  Created by Максим on 19.08.2026.
//

import SwiftUI

struct NetworkErrorView: View {
    let errorType: NetworkErrorType

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(errorType.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)

            Text(errorType.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlackDay)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypWhiteDay)
    }
}

#Preview("Server Error") {
    NetworkErrorView(errorType: .server)
}

#Preview("No Internet") {
    NetworkErrorView(errorType: .noInternet)
}
