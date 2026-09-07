//
//  ScheduleView.swift
//  Travel Schedule
//
//  Created by Максим on 28.07.2026.
//

import SwiftUI

struct ScheduleView: View {
    @State private var selectedRoutePoint: RoutePointKind?
    @State private var selectedStoryGroup: StoryGroup?
    @StateObject private var viewModel = ScheduleViewModel()
    
    let networkClient: NetworkClient
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(viewModel.orderedStoryGroups) { storyGroup in
                        Button {
                            selectedStoryGroup = storyGroup
                        } label: {
                            StoryCardView(
                                storyGroup: storyGroup,
                                isViewed: viewModel.viewedStoryGroupIDs.contains(storyGroup.id)
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
                                Text(viewModel.departure?.displayTitle ?? "Откуда")
                                    .foregroundStyle(
                                        viewModel.departure == nil ? .ypGray : .ypJustBlack
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
                                Text(viewModel.destination?.displayTitle ?? "Куда")
                                    .foregroundStyle(
                                        viewModel.destination == nil ? .ypGray : .ypJustBlack
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
                        viewModel.swapRoutePoints()
                    } label: {
                        Image(.reverseButtonIcon)
                    }
                }
                .padding()
                .background(.ypBlue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 16)
                
                if let departure = viewModel.departure,
                   let destination = viewModel.destination {
                    NavigationLink {
                        CarrierListView(
                            departure: departure,
                            destination: destination,
                            routes: [],
                            networkClient: networkClient
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
            .fullScreenCover(item: $selectedRoutePoint) { routePointKind in
                NavigationStack {
                    CitySelectionView(
                        networkClient: networkClient,
                        onRoutePointSelected: { selectedPoint in
                            viewModel.select(
                                selectedPoint,
                                for: routePointKind
                            )
                            
                            selectedRoutePoint = nil
                        }
                    )
                }
            }
            .fullScreenCover(item: $selectedStoryGroup) { storyGroup in
                StoriesView(
                    storyGroup: storyGroup,
                    onGroupViewed: {
                        viewModel.markStoryGroupAsViewed(storyGroup)
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
    ScheduleView(
        networkClient: try! NetworkClient(apiKey: "")
    )
}
