//
//  CarrierInfoView.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import SwiftUI

struct CarrierInfoView: View {
    @StateObject private var viewModel: CarrierInfoViewModel

    init(
        carrier: Carrier,
        networkClient: NetworkClient
    ) {
        _viewModel = StateObject(
            wrappedValue: CarrierInfoViewModel(
                carrier: carrier,
                networkClient: networkClient
            )
        )
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorType = viewModel.errorType {
                NetworkErrorView(errorType: errorType)
            } else {
                carrierContent
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .task {
            await viewModel.loadCarrierInfo()
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var carrierContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)

                CarrierLogoView(
                    logoName: viewModel.carrier.logoName
                )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 104)

            Text(viewModel.carrier.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlackDay)

            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 12)

                Text("E-mail")
                    .font(.system(size: 17))
                    .foregroundStyle(.ypBlackDay)

                Text(viewModel.carrier.email)
                    .font(.system(size: 12))
                    .foregroundStyle(.ypBlue)

                Spacer(minLength: 24)

                Text("Телефон")
                    .font(.system(size: 17))
                    .foregroundStyle(.ypBlackDay)

                Text(viewModel.carrier.phone)
                    .font(.system(size: 12))
                    .foregroundStyle(.ypBlue)

                Spacer(minLength: 12)
            }
            .frame(maxHeight: 120)

            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView(
            carrier: MockData.fgc,
            networkClient: try! NetworkClient(apiKey: "")
        )
    }
}
