//
//  CarrierListView.swift
//  Travel Schedule
//
//  Created by Максим on 04.08.2026.
//

import SwiftUI

struct CarrierListView: View {
    let departure: RoutePoint
    let destination: RoutePoint
    let routes: [RouteOption]
    @State private var appliedFilters = RouteFilters(selectedTimes: [], showTransfers: nil)
    private var filteredRoutes: [RouteOption] {
        routes.filter { route in
            let matchesTime =
                appliedFilters.selectedTimes.isEmpty
                || appliedFilters.selectedTimes.contains { time in
                    time.contains(route.departureTime)
                }
            
            let matchesTransfers: Bool
            
            if appliedFilters.showTransfers == false {
                matchesTransfers = route.transferDescription == nil
            } else {
                matchesTransfers = true
            }
            
            return matchesTime && matchesTransfers
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(
                "\(departure.displayTitle) → \(destination.displayTitle)"
            )
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.ypBlackDay)
            
            if filteredRoutes.isEmpty {
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
                        ForEach(filteredRoutes) { route in
                            NavigationLink {
                                CarrierInfoView(carrier: route.carrier)
                            } label: {
                                RouteCardView(route: route)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            
            NavigationLink {
                FiltersView(filters: appliedFilters) { newFilters in
                    appliedFilters = newFilters
                }
            } label: {
                Text("Уточнить время")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60,
                        maxHeight: 60,
                    )
                    .foregroundStyle(.ypJustWhite)
                    .font(.system(size: 17, weight: .bold))
                    .background(.ypBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
            }
        }
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .padding(.horizontal, 16)
        .toolbar(.hidden, for: .tabBar)
    }
}


