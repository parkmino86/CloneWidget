//
//  DynamicHeightGridView.swift
//  CloneWidget
//
//  Created by minoh.park on 10/7/24.
//

import SwiftUI

struct DynamicHeightGridView: View {
    @State private var bookmarkedItems: Set<String> = []

    let items = (1...20).map { "Item \($0)" }

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    DynamicHeightCell(content: item, isBookmarked: bookmarkedItems.contains(item)) {
                        toggleBookmark(for: item)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private func toggleBookmark(for item: String) {
        if bookmarkedItems.contains(item) {
            bookmarkedItems.remove(item)
        } else {
            bookmarkedItems.insert(item)
        }
    }
}

struct DynamicHeightCell: View {
    let content: String
    let isBookmarked: Bool
    let onBookmarkTapped: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(content)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("This is some dynamic content that could potentially be longer or shorter depending on the data provided.")
                .font(.body)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Spacer()
                Button(action: onBookmarkTapped) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isBookmarked ? .yellow : .gray)
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicHeightGridView()
    }
}
