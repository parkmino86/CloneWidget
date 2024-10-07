//
//  WaterfallGridView.swift
//  CloneWidget
//
//  Created by minoh.park on 10/7/24.
//

import SwiftUI

extension String: Identifiable {
    public var id: String {
        return self
    }
}

struct WaterfallGridView: View {
    let items = [
        "Bohemian Rhapsody",
        "Stairway to Heaven - A classic by Led Zeppelin.",
        "Hotel California - Eagles' iconic song with haunting melody and vivid storytelling.",
        "Shape of You",
        "Billie Jean - Michael Jackson's legendary track.",
        "Rolling in the Deep - Adele's powerful song of heartbreak and strength.",
        "Imagine",
        "Hey Jude - The Beatles' uplifting anthem.",
        "Smells Like Teen Spirit - Nirvana's grunge revolution.",
        "Like a Rolling Stone",
        "Wonderwall - Oasis' signature track.",
        "Sweet Child O' Mine - Guns N' Roses' rock ballad with unforgettable guitar riffs.",
        "Lose Yourself",
        "Yesterday - The Beatles' melancholic song about loss.",
        "Let It Be - Comforting ballad by The Beatles offering hope.",
        "What's Going On",
        "Purple Rain - Prince's emotional performance combining rock, pop, and soul.",
        "Someone Like You - Adele's ballad of heartbreak and vulnerability.",
        "Take On Me",
        "Blinding Lights - The Weeknd's retro-pop sensation with synth beats."
    ]

    let spacing: CGFloat = 16

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        let columns = horizontalSizeClass == .compact && verticalSizeClass == .regular ? 2 : 4

        ScrollView {
            WaterfallGrid(columns: columns, spacing: spacing, items: items, content: { item in
                WaterfallCell(content: item)
            })
            .padding(.horizontal, spacing)
        }
    }
}

struct WaterfallCell: View {
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(content)
                .font(.body)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

struct WaterfallGrid<Item: Identifiable, Content: View>: View {
    let columns: Int
    let spacing: CGFloat
    let items: [Item]
    let content: (Item) -> Content

    init(columns: Int, spacing: CGFloat, items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.columns = columns
        self.spacing = spacing
        self.items = items
        self.content = content
    }

    var body: some View {
        let groupedItems = groupItems()

        HStack(alignment: .top, spacing: spacing) {
            ForEach(groupedItems.indices, id: \.self) { columnIndex in
                VStack(spacing: spacing) {
                    ForEach(groupedItems[columnIndex]) { item in
                        content(item)
                    }
                }
            }
        }
    }

    private func groupItems() -> [[Item]] {
        var groupedItems = Array(repeating: [Item](), count: columns)
        for (index, item) in items.enumerated() {
            groupedItems[index % columns].append(item)
        }
        return groupedItems
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaterfallGridView()
            .previewInterfaceOrientation(.portrait)
        WaterfallGridView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
