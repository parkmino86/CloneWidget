//
//  SubscriptionPurchaseClient.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import ComposableArchitecture
import Foundation

extension DependencyValues {
    var subscriptionPurchaseClient: SubscriptionPurchaseClient {
        get { self[SubscriptionPurchaseClient.self] }
        set { self[SubscriptionPurchaseClient.self] = newValue }
    }
}

@DependencyClient
struct SubscriptionPurchaseClient {
    var fetchSubscriptionOptions: @Sendable () async throws -> [SubscriptionOption]
    var purchaseSubscription: @Sendable (SubscriptionOption) async throws -> Bool
}

extension SubscriptionPurchaseClient: DependencyKey {
    static let liveValue: SubscriptionPurchaseClient = {
        let service = SubscriptionService()
        return Self(
            fetchSubscriptionOptions: {
                try await service.fetchSubscriptionOptions()
            },
            purchaseSubscription: { option in
                try await service.purchase(option)
            }
        )
    }()

    static let previewValue: SubscriptionPurchaseClient = {
        let service = SubscriptionService()
        return Self(
            fetchSubscriptionOptions: {
                try await service.fetchSubscriptionOptions()
            },
            purchaseSubscription: { option in
                try await service.purchase(option)
            }
        )
    }()
}
