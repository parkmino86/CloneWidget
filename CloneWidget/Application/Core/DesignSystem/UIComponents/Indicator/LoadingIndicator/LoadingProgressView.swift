//
//  LoadingProgressView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/1/24.
//

import ComposableArchitecture
import SwiftUI

@MainActor
final class LoadingStateManager: ObservableObject {
    static let shared = LoadingStateManager()

    @Published private(set) var isLoading: Bool = false
    private var loadingCount: Int = 0

    private init() {}

    func showLoading() {
        loadingCount += 1
        updateLoadingState()
    }

    func hideLoading() {
        loadingCount = max(loadingCount - 1, 0)
        updateLoadingState()
    }

    private func updateLoadingState() {
        isLoading = loadingCount > 0
    }
}

struct LoadingProgressView: View {
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

struct LoadingProgressView_Previews: PreviewProvider {
    static var previews: some View {
            LoadingStateManager.shared.showLoading()
            return LoadingProgressView().previewDisplayName("Loading State")
        }
}
