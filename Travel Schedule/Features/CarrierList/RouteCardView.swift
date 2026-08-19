//
//  RouteCardView.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import SwiftUI

struct RouteCardView: View {
    let route: RouteOption

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 4) {
                Image(route.logoName)
                    .frame(
                        maxWidth: 38,
                        minHeight: 38,
                    )
                    .padding(.leading, 0)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(route.carrierName)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlackDay)
                    if let transferDescription = route.transferDescription {
                        Text(transferDescription)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypRed)
                    }
                }
                
                Spacer()
                
                Text(
                    route.routeDate.formatted(
                        .dateTime
                            .day()
                            .month()
                            .locale(Locale(identifier: "ru_RU"))
                    )
                )
                .font(.system(size: 12, weight: .regular))
                
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            
            HStack(spacing: 4) {
                Text(
                    route.departureTime.formatted(
                        date: .omitted,
                        time: .shortened
                    )
                )
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Spacer(minLength: 1)
                
                Text(route.duration)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                
                Spacer(minLength: 1)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
                
                Text(
                    route.arrivalTime.formatted(
                        date: .omitted,
                        time: .shortened
                    )
                )
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlackDay)
                
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, 14)
        }
        .background(.ypLightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    NavigationStack {
        CarrierListView(
            departure: RoutePoint(
                city: "Москва",
                station: "Ярославский вокзал",
                stationCode: "test-1"
            ),
            destination: RoutePoint(
                city: "Санкт-Петербург",
                station: "Балтийский вокзал",
                stationCode: "test-2"
            ),
            routes: MockData.routeOptions
        )
    }
}
