//
//  CarrierListViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class CarrierListViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var errorType: NetworkErrorType?
    @Published private(set) var routes: [RouteOption]
    @Published private(set) var appliedFilters = RouteFilters(
        selectedTimes: [],
        showTransfers: nil
    )
    
    private let isoDateFormatter = ISO8601DateFormatter()
    private let networkClient: NetworkClient
    
    let departure: RoutePoint
    let destination: RoutePoint

    init(
        departure: RoutePoint,
        destination: RoutePoint,
        routes: [RouteOption],
        networkClient: NetworkClient
    ) {
        self.departure = departure
        self.destination = destination
        self.routes = routes
        self.networkClient = networkClient
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    var filteredRoutes: [RouteOption] {
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

    func applyFilters(_ filters: RouteFilters) {
        appliedFilters = filters
    }
    
    func loadRoutes() async {
        guard routes.isEmpty else { return }
        
        isLoading = true
        errorType = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await networkClient.searchRoutes(
                from: departure.stationCode,
                to: destination.stationCode
            )

            routes = makeRoutes(from: response)
        } catch is CancellationError {
            return
        } catch {
            errorType = NetworkErrorType.from(error)
        }
    }
    
    private func makeDurationText(seconds: Double) -> String {
        let totalMinutes = Int(seconds) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        if hours == 0 {
            return "\(minutes) мин"
        }

        if minutes == 0 {
            return "\(hours) ч"
        }

        return "\(hours) ч \(minutes) мин"
    }
    
    private func makeRoutes(
        from response: SearchRoutes
    ) -> [RouteOption] {
        (response.segments ?? []).compactMap { segment in
            guard let departureTime = segment.departure else {
                return nil
            }

            let departureDate: Date?

            if let isoDate = isoDateFormatter.date(from: departureTime) {
                departureDate = isoDate
            } else if let startDate = segment.start_date {
                departureDate = dateFormatter.date(
                    from: "\(startDate) \(departureTime)"
                )
            } else {
                departureDate = nil
            }

            guard let departureDate else {
                return nil
            }

            let arrivalDate: Date
            let duration: Double

            if let segmentDuration = segment.duration {
                duration = segmentDuration
                arrivalDate = departureDate.addingTimeInterval(segmentDuration)
            } else if
                let arrivalTime = segment.arrival,
                let parsedArrivalDate = isoDateFormatter.date(from: arrivalTime)
            {
                arrivalDate = parsedArrivalDate
                duration = parsedArrivalDate.timeIntervalSince(departureDate)
            } else {
                return nil
            }

            let apiCarrier =
                segment.thread?.carrier
                ?? segment.details?
                    .compactMap { $0.thread?.carrier }
                    .first

            let directTransferTitles = (segment.transfers ?? [])
                .compactMap(\.title)

            let detailTransferTitles = (segment.details ?? [])
                .filter { $0.is_transfer == true }
                .compactMap { detail in
                    detail.transfer_to?.title
                        ?? detail.transfer_from?.title
                }

            let transferTitles = (
                directTransferTitles + detailTransferTitles
            ).reduce(into: [String]()) { result, title in
                if !result.contains(title) {
                    result.append(title)
                }
            }

            let hasTransfers =
                segment.has_transfers == true
                || !(segment.transfers ?? []).isEmpty
                || (segment.details ?? []).contains {
                    $0.is_transfer == true
                }

            let transferDescription: String?

            if hasTransfers {
                transferDescription = transferTitles.isEmpty
                    ? "С пересадкой"
                    : "С пересадкой в \(transferTitles.joined(separator: ", "))"
            } else {
                transferDescription = nil
            }

            return RouteOption(
                id: UUID(),
                carrier: Carrier(
                    code: apiCarrier?.code,
                    name: apiCarrier?.title ?? "Перевозчик",
                    logoName: apiCarrier?.logo ?? "",
                    email: apiCarrier?.email ?? "",
                    phone: apiCarrier?.phone ?? ""
                ),
                routeDate: departureDate,
                departureTime: departureDate,
                arrivalTime: arrivalDate,
                duration: makeDurationText(seconds: duration),
                transferDescription: transferDescription
            )
        }
    }
}
