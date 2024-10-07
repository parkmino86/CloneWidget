//
//  WaterfallGrid.swift
//  CloneWidget
//
//  Created by minoh.park on 10/7/24.
//

import SwiftUI

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
