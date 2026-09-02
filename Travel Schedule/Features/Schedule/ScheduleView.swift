//
//  ScheduleView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct ScheduleView: View {
    @State private var selectedRoutePoint: RoutePointKind?
    @State private var departure: RoutePoint?
    @State private var destination: RoutePoint?
    @State private var selectedStoryGroup: StoryGroup?
    @State private var viewedStoryGroupIDs: Set<Int> = []
    
    private var orderedStoryGroups: [StoryGroup] {
        let unviewed = MockData.storyGroups.filter {
            !viewedStoryGroupIDs.contains($0.id)
        }

        let viewed = MockData.storyGroups.filter {
            viewedStoryGroupIDs.contains($0.id)
        }

        return unviewed + viewed
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(orderedStoryGroups) { storyGroup in
                        Button {
                            selectedStoryGroup = storyGroup
                        } label: {
                            StoryCardView(
                                storyGroup: storyGroup,
                                isViewed: viewedStoryGroupIDs.contains(storyGroup.id)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 188)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    VStack(spacing: 0) {
                        Button {
                            selectedRoutePoint = .departure
                        } label: {
                            HStack {
                                Text(departure?.displayTitle ?? "Откуда")
                                    .foregroundStyle(
                                        departure == nil ? .ypGray : .ypJustBlack
                                    )
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding()
                        }
                        Button {
                            selectedRoutePoint = .destination
                        } label: {
                            HStack {
                                Text(destination?.displayTitle ?? "Куда")
                                    .foregroundStyle(
                                        destination == nil ? .ypGray : .ypJustBlack
                                    )
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .background(.ypJustWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Button {
                        let previousDeparture = departure
                        departure = destination
                        destination = previousDeparture
                    } label: {
                        Image(.reverseButtonIcon)
                    }
                }
                .padding()
                .background(.ypBlue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 16)
                
                if let departure,
                   let destination {
                    NavigationLink {
                        CarrierListView(
                            departure: departure,
                            destination: destination,
                            routes: MockData.routeOptions
                        )
                    } label: {
                        Text("Найти")
                            .foregroundStyle(.ypJustWhite)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(width: 150, height: 60)
                    .background(.ypBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            .fullScreenCover(item: $selectedStoryGroup) { storyGroup in
                StoriesView(
                    storyGroup: storyGroup,
                    onGroupViewed: {
                        viewedStoryGroupIDs.insert(storyGroup.id)
                    }
                )
            }
        }
        .background {
            Color(.ypWhiteDay)
                .ignoresSafeArea()
        }
    }
}


#Preview {
    ScheduleView()
}
