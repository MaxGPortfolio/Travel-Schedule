//
//  StoryCardView.swift
//  Travel Schedule
//
//  Created by Максим on 01.09.2026.
//

import SwiftUI

import SwiftUI

struct StoryCardView: View {
    let storyGroup: StoryGroup
    let isViewed: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(storyGroup.previewImageName)
                .resizable()
                .scaledToFill()

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.7)
                ],
                startPoint: .center,
                endPoint: .bottom
            )

            Text(storyGroup.previewTitle)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white)
                .lineLimit(3)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if !isViewed {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.ypBlue, lineWidth: 4)
            }
        }
        .opacity(isViewed ? 0.5 : 1)
    }
}

#Preview {
    StoryCardView(storyGroup: MockData.storyGroups[0], isViewed: true)
}
