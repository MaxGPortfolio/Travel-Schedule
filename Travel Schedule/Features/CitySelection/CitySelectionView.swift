//
//  CitySelectionView.swift
//  Travel Schedule
//
//  Created by Максим on 29.07.2026.
//

import SwiftUI

struct CitySelectionView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    let onRoutePointSelected: (RoutePoint) -> Void
    
    private let cities = [
            "Москва",
            "Санкт-Петербург",
            "Сочи",
            "Горный воздух",
            "Краснодар",
            "Казань",
            "Омск"
        ]
    
    private var filteredCities: [String] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else { return cities }
        
        return cities.filter { $0.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                
                TextField("Введите запрос", text: $searchText)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
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
            
            if filteredCities.isEmpty {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            } else {
                List(filteredCities, id: \.self) { city in
                    NavigationLink {
                        StationSelectionView(
                            stations: MockData.stationsByCity[city] ?? [],
                            onStationSelected: { station in
                                let routePoint = RoutePoint(
                                    city: city,
                                    station: station.title,
                                    stationCode: station.code
                                )
                                onRoutePointSelected(routePoint)
                            }
                        )
                    } label: {
                        HStack {
                            Text(city)
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
    }
}

#Preview {
    NavigationStack {
        CitySelectionView { point in
            print(point)
        }
    }
}
