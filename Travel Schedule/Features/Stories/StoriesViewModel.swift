//
//  StoriesViewModel.swift
//  Travel Schedule
//
//  Created by Максим on 07.09.2026.
//

import Combine
import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published private(set) var progress: CGFloat = 0
    @Published private(set) var viewedStoryIDs: Set<Int> = []

    let storyGroup: StoryGroup

    private let storyDuration: TimeInterval = 10

    init(storyGroup: StoryGroup) {
        self.storyGroup = storyGroup
    }

    var currentIndex: Int {
        guard !storyGroup.stories.isEmpty else {
            return 0
        }

        return min(
            Int(progress * CGFloat(storyGroup.stories.count)),
            storyGroup.stories.count - 1
        )
    }

    var currentStory: Story {
        storyGroup.stories[currentIndex]
    }

    var isGroupViewed: Bool {
        viewedStoryIDs.count == storyGroup.stories.count
    }

    func showNextStory() -> Bool {
        let nextIndex = currentIndex + 1

        guard nextIndex < storyGroup.stories.count else {
            return true
        }

        progress =
            CGFloat(nextIndex)
            / CGFloat(storyGroup.stories.count)

        return false
    }

    func showPreviousStory() {
        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else {
            return
        }

        progress =
            CGFloat(previousIndex)
            / CGFloat(storyGroup.stories.count)
    }

    func timerTick(
        tickInterval: TimeInterval
    ) -> Bool {
        guard !storyGroup.stories.isEmpty else {
            return true
        }

        let progressPerTick =
            1.0
            / CGFloat(storyGroup.stories.count)
            / storyDuration
            * tickInterval

        let nextProgress = progress + progressPerTick

        guard nextProgress < 1 else {
            return true
        }

        progress = nextProgress
        return false
    }

    func markCurrentStoryViewed() {
        viewedStoryIDs.insert(currentStory.id)
    }
}
