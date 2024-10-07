//
//  WaterfallCell.swift
//  CloneWidget
//
//  Created by minoh.park on 10/7/24.
//

import SwiftUI

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
