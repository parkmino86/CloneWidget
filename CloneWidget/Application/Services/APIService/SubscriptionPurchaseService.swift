//
//  SubscriptionPurchaseService.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import Foundation

actor SubscriptionService {
    private var availableSubscriptions: [SubscriptionOption] = [
        SubscriptionOption(id: UUID(), name: "1-Month Plan", price: 9.99),
        SubscriptionOption(id: UUID(), name: "6-Month Plan", price: 49.99),
        SubscriptionOption(id: UUID(), name: "1-Year Plan", price: 89.99)
    ]

    func fetchSubscriptionOptions() async throws -> [SubscriptionOption] {
        return availableSubscriptions
    }

    func purchase(_ option: SubscriptionOption) async throws -> Bool {
        // 실제로는 네트워크 요청을 보내거나 결제 로직을 처리해야 합니다.
        // 여기서는 단순히 성공을 반환합니다.
        return true
    }
}
