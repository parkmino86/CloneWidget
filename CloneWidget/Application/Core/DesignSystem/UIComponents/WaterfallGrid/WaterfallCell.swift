//
//  WaterfallCell.swift
//  CloneWidget
//
//  Created by minoh.park on 10/7/24.
//

import SwiftUI

struct WaterfallCell: View {
    let content: String
    @State private var isBookmarked: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(content)
                .font(.body)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Spacer()
                Button(action: {
                    isBookmarked.toggle()
                }) {
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

struct WaterfallCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaterfallCell(content: "Bohemian Rhapsody")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Short Text")

            WaterfallCell(content: "Stairway to Heaven - A classic by Led Zeppelin.")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Medium Text")
            
            WaterfallCell(content: "Hotel California - Eagles' iconic song with haunting melody and vivid storytelling.")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Long Text")
        }
    }
}
