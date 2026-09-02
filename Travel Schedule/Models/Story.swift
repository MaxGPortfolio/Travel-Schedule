//
//  Story.swift
//  Travel Schedule
//
//  Created by Максим on 01.09.2026.
//

import Foundation

struct StoryGroup: Identifiable, Hashable {
    let id: Int
    let previewImageName: String
    let previewTitle: String
    let stories: [Story]
}

struct Story: Identifiable, Hashable {
    let id: Int
    let imageName: String
    let title: String
    let description: String
}
