//
//  FotoService.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import Foundation

actor FotoService {
    private var storedMembers: [ProfileCore.State] = [
        ProfileCore.State(name: "Hongjoong", group: "ATEEZ"),
        ProfileCore.State(name: "Seonghwa", group: "ATEEZ"),
        ProfileCore.State(name: "Yunho", group: "ATEEZ"),
        ProfileCore.State(name: "Yeosang", group: "ATEEZ"),
        ProfileCore.State(name: "San", group: "ATEEZ"),
        ProfileCore.State(name: "Mingi", group: "ATEEZ"),
        ProfileCore.State(name: "Wooyoung", group: "ATEEZ"),
        ProfileCore.State(name: "Jongho", group: "ATEEZ"),
        ProfileCore.State(name: "RM", group: "BTS"),
        ProfileCore.State(name: "Jin", group: "BTS"),
        ProfileCore.State(name: "Suga", group: "BTS"),
        ProfileCore.State(name: "J-Hope", group: "BTS"),
        ProfileCore.State(name: "Jimin", group: "BTS"),
        ProfileCore.State(name: "V", group: "BTS"),
        ProfileCore.State(name: "Jungkook", group: "BTS"),
        ProfileCore.State(name: "Jisoo", group: "BLACKPINK"),
        ProfileCore.State(name: "Jennie", group: "BLACKPINK"),
        ProfileCore.State(name: "Rosé", group: "BLACKPINK"),
        ProfileCore.State(name: "Lisa", group: "BLACKPINK"),
    ]

    private var storedArtists: [CategoryButtonCore.State] = [
        CategoryButtonCore.State(text: "ATEEZ", isSelected: true),
        CategoryButtonCore.State(text: "BTS", isSelected: false),
        CategoryButtonCore.State(text: "BLACKPINK", isSelected: false),
    ]

    func fetchArtistMembers(for group: String) async throws -> [ProfileCore.State] {
        return storedMembers.filter { $0.group == group }
    }

    func fetchArtists() async throws -> [CategoryButtonCore.State] {
        return storedArtists
    }
}
