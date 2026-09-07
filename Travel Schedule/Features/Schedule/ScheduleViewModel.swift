//
//  ScheduleViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published private(set) var departure: RoutePoint?
    @Published private(set) var destination: RoutePoint?
    @Published private(set) var viewedStoryGroupIDs: Set<Int> = []

    private let storyGroups: [StoryGroup]

    init(storyGroups: [StoryGroup] = MockData.storyGroups) {
        self.storyGroups = storyGroups
    }

    var orderedStoryGroups: [StoryGroup] {
        let unviewed = storyGroups.filter {
            !viewedStoryGroupIDs.contains($0.id)
        }

        let viewed = storyGroups.filter {
            viewedStoryGroupIDs.contains($0.id)
        }

        return unviewed + viewed
    }

    var canSearch: Bool {
        departure != nil && destination != nil
    }

    func select(
        _ routePoint: RoutePoint,
        for kind: RoutePointKind
    ) {
        switch kind {
        case .departure:
            departure = routePoint

        case .destination:
            destination = routePoint
        }
    }

    func swapRoutePoints() {
        let previousDeparture = departure
        departure = destination
        destination = previousDeparture
    }

    func markStoryGroupAsViewed(_ storyGroup: StoryGroup) {
        viewedStoryGroupIDs.insert(storyGroup.id)
    }
}
