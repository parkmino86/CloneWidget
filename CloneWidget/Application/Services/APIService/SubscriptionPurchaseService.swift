//
//  SubscriptionPurchaseService.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import Foundation

actor SubscriptionService {
    private var availableSubscriptions: [SubscriptionOption] = [
        SubscriptionOption(id: UUID(), name: "foto 1인권", price: 5500),
        SubscriptionOption(id: UUID(), name: "foto 2인권", price: 11000),
        SubscriptionOption(id: UUID(), name: "foto 3인권", price: 16500),
        SubscriptionOption(id: UUID(), name: "foto 4인권", price: 22000),
        SubscriptionOption(id: UUID(), name: "foto 5인권", price: 27500),
        SubscriptionOption(id: UUID(), name: "foto 6인권", price: 33000),
        SubscriptionOption(id: UUID(), name: "foto 7인권", price: 38500),
        SubscriptionOption(id: UUID(), name: "foto 8인권", price: 44000),
    ]

    func fetchSubscriptionOptions() async throws -> [SubscriptionOption] {
        return availableSubscriptions
    }

    func purchase(_: SubscriptionOption) async throws -> Bool {
        // 실제로는 네트워크 요청을 보내거나 결제 로직을 처리해야 합니다.
        // 여기서는 단순히 성공을 반환합니다.
        return true
    }
}
