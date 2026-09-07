//
//  StoriesView.swift
//  Travel Schedule
//
//  Created by Максим on 02.09.2026.
//

import Combine
import SwiftUI

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: StoriesViewModel

    let onGroupViewed: () -> Void

    private let tickInterval: TimeInterval = 0.05

    private let timer = Timer.publish(
        every: 0.05,
        on: .main,
        in: .common
    ).autoconnect()

    init(
        storyGroup: StoryGroup,
        onGroupViewed: @escaping () -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: StoriesViewModel(
                storyGroup: storyGroup
            )
        )
        self.onGroupViewed = onGroupViewed
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(viewModel.currentStory.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .clipped()
                .id(viewModel.currentStory.id)
                .transition(.opacity)

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.8)
                ],
                startPoint: .center,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.currentStory.title)
                    .lineLimit(2)
                    .font(.system(size: 34, weight: .bold))

                Text(viewModel.currentStory.description)
                    .font(.system(size: 20))
                    .lineLimit(3)
            }
            .foregroundStyle(.white)
            .padding(.bottom, 40)
            .padding(.horizontal, 16)

            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.showPreviousStory()
                    }

                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if viewModel.showNextStory() {
                            dismiss()
                        }
                    }
            }

            VStack {
                StoriesProgressBar(
                    numberOfSections:
                        viewModel.storyGroup.stories.count,
                    progress: viewModel.progress
                )

                HStack {
                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(
                                .ypJustBlack.opacity(0.8)
                            )
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .padding(16)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 40)
        )
        .background(
            Color.ypJustBlack.ignoresSafeArea()
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    handleSwipe(value)
                }
        )
        .onReceive(timer) { _ in
            let shouldDismiss = withAnimation(
                .linear(duration: tickInterval)
            ) {
                viewModel.timerTick(
                    tickInterval: tickInterval
                )
            }

            if shouldDismiss {
                dismiss()
            }
        }
        .onAppear {
            viewModel.markCurrentStoryViewed()
        }
        .onChange(of: viewModel.currentIndex) { _, _ in
            viewModel.markCurrentStoryViewed()
        }
        .onDisappear {
            if viewModel.isGroupViewed {
                onGroupViewed()
            }
        }
    }

    private func handleSwipe(
        _ value: DragGesture.Value
    ) {
        let horizontal = value.translation.width
        let vertical = value.translation.height

        if abs(vertical) > abs(horizontal) {
            if vertical > 100 {
                dismiss()
            }
            return
        }

        guard abs(horizontal) > 60 else {
            return
        }

        if horizontal < 0 {
            if viewModel.showNextStory() {
                dismiss()
            }
        } else {
            viewModel.showPreviousStory()
        }
    }
}

private struct StoriesProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let normalizedProgress = min(
                max(progress, 0),
                1
            )

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white)

                RoundedRectangle(cornerRadius: 2)
                    .fill(.ypBlue)
                    .frame(
                        width: geometry.size.width
                            * normalizedProgress
                    )
            }
            .mask {
                HStack(spacing: 6) {
                    ForEach(
                        0..<numberOfSections,
                        id: \.self
                    ) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(height: 4)
    }
}

#Preview {
    StoriesView(
        storyGroup: MockData.storyGroups[0],
        onGroupViewed: {}
    )
}
