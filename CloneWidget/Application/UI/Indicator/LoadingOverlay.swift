//
//  LoadingOverlay.swift
//  CloneWidget
//
//  Created by minoh.park on 8/27/24.
//

import SwiftUI

struct LoadingOverlay: View {
    @ObservedObject private var loadingIndicator = LoadingIndicator.shared

    var body: some View {
        if loadingIndicator.isLoading {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
            .transition(.opacity.animation(.easeInOut(duration: 0.2)))
        }
    }
}
