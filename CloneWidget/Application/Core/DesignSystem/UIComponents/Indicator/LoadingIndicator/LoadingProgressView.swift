//
//  LoadingProgressView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/1/24.
//

import ComposableArchitecture
import SwiftUI

// MARK: - View

struct LoadingProgressView: View {
    let store: StoreOf<LoadingProgressCore>

    var body: some View {
        if store.isLoading {
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

// MARK: - Reducer

@Reducer
struct LoadingProgressCore {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        var loadingCount: Int = 0
    }

    enum Action: Equatable {
        case showLoading
        case hideLoading
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showLoading:
                state.loadingCount += 1
                state.isLoading = state.loadingCount > 0
                return .none

            case .hideLoading:
                state.loadingCount = max(state.loadingCount - 1, 0)
                state.isLoading = state.loadingCount > 0
                return .none
            }
        }
    }
}

// MARK: - Preview

struct LoadingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingProgressView(
            store: Store(
                initialState: LoadingProgressCore.State(isLoading: true),
                reducer: { LoadingProgressCore() }
            )
        )
    }
}
