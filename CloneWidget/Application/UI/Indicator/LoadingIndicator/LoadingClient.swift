//
//  LoadingClient.swift
//  CloneWidget
//
//  Created by minoh.park on 8/27/24.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct LoadingClient {
    var show: @Sendable () async -> Void
    var hide: @Sendable () async -> Void
}

extension DependencyValues {
    var loadingClient: LoadingClient {
        get { self[LoadingClientKey.self] }
        set { self[LoadingClientKey.self] = newValue }
    }
}

private enum LoadingClientKey: DependencyKey {
    static let liveValue = LoadingClient(
        show: {
            await MainActor.run {
                LoadingStateManager.shared.showLoading()
            }
        },
        hide: {
            await MainActor.run {
                LoadingStateManager.shared.hideLoading()
            }
        }
    )
}
