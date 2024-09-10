//
//  CustomBackButton.swift
//  CloneWidget
//
//  Created by minoh.park on 9/11/24.
//

import SwiftUI

struct CustomBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.primary)
        }
    }
}
