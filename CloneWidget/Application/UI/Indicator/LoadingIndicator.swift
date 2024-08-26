//
//  LoadingIndicator.swift
//  CloneWidget
//
//  Created by minoh.park on 8/27/24.
//

import Combine
import SwiftUI

final class LoadingIndicator: ObservableObject {
    static let shared = LoadingIndicator()

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
