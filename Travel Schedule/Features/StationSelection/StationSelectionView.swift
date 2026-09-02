//
//  StationSelection.swift
//  Travel Schedule
//
//  Created by Максим on 30.07.2026.
//

import SwiftUI

struct StationSelectionView: View {
    @State private var searchText = ""
    let onStationSelected: (Station) -> Void
    
    private let stations: [Station]
    
    private var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else { return stations }
        
        return stations.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
    
    init(
        stations: [Station],
        onStationSelected: @escaping (Station) -> Void
    ) {
        self.stations = stations
        self.onStationSelected = onStationSelected
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
            
            if filteredStations.isEmpty {
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            } else {
                List(filteredStations, id: \.self) { station in
                    Button {
                        onStationSelected(station)
                    } label: {
                        HStack {
                            Text(station.title)
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
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 16,
                            bottom: 0,
                            trailing: 16
                        )
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.ypWhiteDay)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .contentMargins(.top, 0, for: .scrollContent)
            }
        }
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(
            stations: [
                Station(
                    code: "test-1",
                    title: "Ярославский вокзал"
                ),
                Station(
                    code: "test-2",
                    title: "Курский вокзал"
                )
            ],
            onStationSelected: { station in
                print(station.title)
                print(station.code)
            }
        )
    }
}
