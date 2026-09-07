//
//  CitySelectionView.swift
//  Travel Schedule
//
//  Created by Максим on 29.07.2026.
//

import SwiftUI

struct CitySelectionView: View {
    @StateObject private var viewModel: CitySelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    let onRoutePointSelected: (RoutePoint) -> Void
    
    init(
        networkClient: NetworkClient,
        onRoutePointSelected: @escaping (RoutePoint) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: CitySelectionViewModel(
                networkClient: networkClient
            )
        )
        self.onRoutePointSelected = onRoutePointSelected
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                
                TextField("Введите запрос", text: $viewModel.searchText)
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .tint(.ypGray)
                    }
                }
            }
            .padding(.horizontal, 8)
            .frame(
                height: 36,
            )
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.ypLightGray)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorType = viewModel.errorType {
                NetworkErrorView(errorType: errorType)
            } else if viewModel.filteredCities.isEmpty {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.filteredCities) { city in
                    NavigationLink {
                        StationSelectionView(
                            stations: city.stations,
                            onStationSelected: { station in
                                let routePoint = RoutePoint(
                                    city: city.title,
                                    station: station.title,
                                    stationCode: station.code
                                )
                                onRoutePointSelected(routePoint)
                            }
                        )
                    } label: {
                        HStack {
                            Text(city.title)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.primary)
                        }
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 60,
                            alignment: .leading
                        )
                    }
                    .listRowBackground(Color.ypWhiteDay)
                    .navigationLinkIndicatorVisibility(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 16,
                            bottom: 0,
                            trailing: 16
                        )
                    )
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .contentMargins(.top, 0, for: .scrollContent)
            }
        }
        .task {
            await viewModel.loadCities()
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primary)
                }
            }
        }
        .background(Color.ypWhiteDay.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        CitySelectionView(
            networkClient: try! NetworkClient(apiKey: "")
        ) { point in
            print(point)
        }
    }
}
