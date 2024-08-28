//
//  LoadingProgressOverlay.swift
//  CloneWidget
//
//  Created by minoh.park on 8/27/24.
//

import Combine
import SwiftUI

struct LoadingProgressOverlay: View {
    @ObservedObject private var state = LoadingStateManager.shared

    var body: some View {
        if state.isLoading {
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
