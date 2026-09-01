//
//  MockData.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import Foundation

enum MockData {
    static let routeOptions: [RouteOption] = [
        RouteOption(
            id: UUID(),
            carrierName: "РЖД",
            logoName: "RzdBrandLogo",
            routeDate: makeDate(day: 14, hour: 0, minute: 0),
            departureTime: makeDate(day: 14, hour: 22, minute: 30),
            arrivalTime: makeDate(day: 15, hour: 8, minute: 15),
            duration: "20 часов",
            transferDescription: "С пересадкой в Костроме"
        ),
        
        RouteOption(
            id: UUID(),
            carrierName: "ФГК",
            logoName: "FgcBrandLogo",
            routeDate: makeDate(day: 15, hour: 0, minute: 0),
            departureTime: makeDate(day: 15, hour: 1, minute: 15),
            arrivalTime: makeDate(day: 15, hour: 9, minute: 0),
            duration: "9 часов",
            transferDescription: nil
        ),

        RouteOption(
            id: UUID(),
            carrierName: "Урал логистика",
            logoName: "UralBrandLogo",
            routeDate: makeDate(day: 16, hour: 0, minute: 0),
            departureTime: makeDate(day: 16, hour: 12, minute: 30),
            arrivalTime: makeDate(day: 16, hour: 21, minute: 0),
            duration: "9 часов",
            transferDescription: nil
        ),

        RouteOption(
            id: UUID(),
            carrierName: "РЖД",
            logoName: "RzdBrandLogo",
            routeDate: makeDate(day: 17, hour: 0, minute: 0),
            departureTime: makeDate(day: 17, hour: 22, minute: 30),
            arrivalTime: makeDate(day: 18, hour: 8, minute: 15),
            duration: "20 часов",
            transferDescription: "С пересадкой в Костроме"
        )
    ]
    
    static let stationsByCity: [String: [Station]] = [
        "Москва": [
            Station(
                code: "s9600943",
                title: "Ярославский вокзал"
            ),
            Station(
                code: "s2000001",
                title: "Курский вокзал"
            )
        ],

        "Санкт-Петербург": [
            Station(
                code: "s9602494",
                title: "Балтийский вокзал"
            ),
            Station(
                code: "s9602497",
                title: "Московский вокзал"
            )
        ],
        
        "Сочи": [
            Station(
                code: "mock-sochi-1",
                title: "Сочи"
            ),
            Station(
                code: "mock-sochi-2",
                title: "Адлер"
            )
        ],

        "Горный воздух": [
            Station(
                code: "mock-gorny-1",
                title: "Горный воздух"
            ),
            Station(
                code: "mock-gorny-2",
                title: "Южно-Сахалинск"
            )
        ],

        "Краснодар": [
            Station(
                code: "mock-krasnodar-1",
                title: "Краснодар-1"
            ),
            Station(
                code: "mock-krasnodar-2",
                title: "Краснодар-2"
            )
        ],

        "Казань": [
            Station(
                code: "mock-kazan-1",
                title: "Казань-Пасс."
            ),
            Station(
                code: "mock-kazan-2",
                title: "Восстание-Пасс."
            )
        ],

        "Омск": [
            Station(
                code: "mock-omsk-1",
                title: "Омск-Пасс."
            ),
            Station(
                code: "mock-omsk-2",
                title: "Омск-Северный"
            )
        ]
    ]
    
    private static func makeDate(
        day: Int,
        hour: Int,
        minute: Int
    ) -> Date {
        DateComponents(
            calendar: .current,
            year: 2026,
            month: 1,
            day: day,
            hour: hour,
            minute: minute
        ).date!
    }
}

