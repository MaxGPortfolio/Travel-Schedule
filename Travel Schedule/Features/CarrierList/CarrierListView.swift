//
//  CarrierListView.swift
//  Travel Schedule
//
//  Created by Максим on 04.08.2026.
//

import SwiftUI

struct CarrierListView: View {
    @StateObject private var viewModel: CarrierListViewModel

    private let networkClient: NetworkClient

    init(
        departure: RoutePoint,
        destination: RoutePoint,
        routes: [RouteOption],
        networkClient: NetworkClient
    ) {
        _viewModel = StateObject(
            wrappedValue: CarrierListViewModel(
                departure: departure,
                destination: destination,
                routes: routes,
                networkClient: networkClient
            )
        )

        self.networkClient = networkClient
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            } else if let errorType = viewModel.errorType {
                NetworkErrorView(errorType: errorType)
            } else {
                VStack(spacing: 16) {
                    Text(
                        "\(viewModel.departure.displayTitle) → "
                            + "\(viewModel.destination.displayTitle)"
                    )
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlackDay)

                    if viewModel.filteredRoutes.isEmpty {
                        Text("Вариантов нет")
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity
                            )
                            .foregroundStyle(.ypBlackDay)
                            .font(.system(size: 24, weight: .bold))
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(
                                    viewModel.filteredRoutes
                                ) { route in
                                    NavigationLink {
                                        CarrierInfoView(
                                            carrier: route.carrier,
                                            networkClient: networkClient
                                        )
                                    } label: {
                                        RouteCardView(route: route)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }

                    NavigationLink {
                        FiltersView(
                            filters: viewModel.appliedFilters
                        ) { newFilters in
                            viewModel.applyFilters(newFilters)
                        }
                    } label: {
                        Text("Уточнить время")
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 60,
                                maxHeight: 60
                            )
                            .foregroundStyle(.ypJustWhite)
                            .font(.system(size: 17, weight: .bold))
                            .background(.ypBlue)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 16)
                            )
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                    }
                }
            }
        }
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .task {
            await viewModel.loadRoutes()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        CarrierListView(
            departure: RoutePoint(
                city: "Москва",
                station: "Ленинградский вокзал",
                stationCode: "test-1"
            ),
            destination: RoutePoint(
                city: "Санкт-Петербург",
                station: "Московский вокзал",
                stationCode: "test-2"
            ),
            routes: MockData.routeOptions,
            networkClient: try! NetworkClient(apiKey: "")
        )
    }
}
