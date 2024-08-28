//
//  LoadingStateManager.swift
//  CloneWidget
//
//  Created by minoh.park on 8/28/24.
//

import Foundation

final class LoadingStateManager: ObservableObject {
    static let shared = LoadingStateManager()

    @Published private(set) var isLoading: Bool = false
    private var loadingCount: Int = 0

    private init() {}

    func showLoading() {
        DispatchQueue.main.async {
            self.loadingCount += 1
            self.updateLoadingState()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingCount = max(self.loadingCount - 1, 0)
            self.updateLoadingState()
        }
    }

    private func updateLoadingState() {
        isLoading = loadingCount > 0
    }
}
