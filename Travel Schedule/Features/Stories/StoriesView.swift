//
//  StoriesView.swift
//  Travel Schedule
//
//  Created by Максим on 02.09.2026.
//

import SwiftUI
import Combine

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var viewedStoryIDs: Set<Int> = []
    
    let storyGroup: StoryGroup
    let onGroupViewed: () -> Void
    
    private var currentIndex: Int {
        guard !storyGroup.stories.isEmpty else {
            return 0
        }

        return min(
            Int(progress * CGFloat(storyGroup.stories.count)),
            storyGroup.stories.count - 1
        )
    }

    private var currentStory: Story {
        storyGroup.stories[currentIndex]
    }
    
    private let storyDuration: TimeInterval = 10
    
    private let timer = Timer.publish(
        every: 0.05,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(currentStory.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .clipped()
                .id(currentStory.id)
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
                Text(currentStory.title)
                    .lineLimit(2)
                    .font(.system(size: 34, weight: .bold))
                
                Text(currentStory.description)
                    .font(.system(size: 20, weight: .regular))
                    .lineLimit(3)
            }
            .foregroundStyle(.white)
            .padding(.bottom, 40)
            .padding(.horizontal, 16)
            
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showPreviousStory()
                    }
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showNextStory()
                    }
            }
            
            VStack {
                StoriesProgressBar(
                    numberOfSections: storyGroup.stories.count,
                    progress: progress
                )
                
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(.ypJustBlack.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .background(Color.ypJustBlack.ignoresSafeArea())
        .simultaneousGesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    handleSwipe(value)
                }
        )
        .onReceive(timer) { _ in
            timerTick()
        }
        .onAppear {
            markCurrentStoryViewed()
        }
        .onChange(of: currentIndex) { _, _ in
            markCurrentStoryViewed()
        }
        .onDisappear {
            if viewedStoryIDs.count == storyGroup.stories.count {
                onGroupViewed()
            }
        }
    }
    
    private func showNextStory() {
        let nextIndex = currentIndex + 1

        guard nextIndex < storyGroup.stories.count else {
            dismiss()
            return
        }

        progress =
            CGFloat(nextIndex)
            / CGFloat(storyGroup.stories.count)
    }

    private func showPreviousStory() {
        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else {
            return
        }

        progress =
            CGFloat(previousIndex)
            / CGFloat(storyGroup.stories.count)
    }
    
    private func timerTick() {
        guard !storyGroup.stories.isEmpty else {
            return
        }

        let tickInterval: TimeInterval = 0.05

        let progressPerTick =
            1.0
            / CGFloat(storyGroup.stories.count)
            / storyDuration
            * tickInterval

        let nextProgress = progress + progressPerTick

        guard nextProgress < 1 else {
            dismiss()
            return
        }

        withAnimation(.linear(duration: tickInterval)) {
            progress = nextProgress
        }
    }
    
    private func handleSwipe(_ value: DragGesture.Value) {
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
            showNextStory()
        } else {
            showPreviousStory()
        }
    }
    
    private func markCurrentStoryViewed() {
        viewedStoryIDs.insert(currentStory.id)
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
                    ForEach(0..<numberOfSections, id: \.self) { _ in
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

