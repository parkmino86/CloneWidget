//
//  SubscriptionPurchaseDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SubscriptionPurchaseDomain {
    @Dependency(\.subscriptionPurchaseClient) var subscriptionPurchaseClient

    @ObservableState
    struct State: Equatable {
        var subscriptionOption: SubscriptionOptionCore.State = .init(options: IdentifiedArrayOf())        
    }

    enum Action: Equatable {
        case onAppear
        case fetchSubscriptionOptions
        case fetchSubscriptionOptionsResponse(TaskResult<[SubscriptionOption]>)

        case purchaseButtonTapped
        case subscriptionOption(SubscriptionOptionCore.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.subscriptionOption, action: \.subscriptionOption) {
            SubscriptionOptionCore()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchSubscriptionOptions)

            case .fetchSubscriptionOptions:
                return .run { send in
                    do {
                        let options = try await subscriptionPurchaseClient.fetchSubscriptionOptions()
                        await send(.fetchSubscriptionOptionsResponse(.success(options)))
                    } catch {
                        await send(.fetchSubscriptionOptionsResponse(.failure(error)))
                    }
                }

            case let .fetchSubscriptionOptionsResponse(result):
                switch result {
                case let .success(options):
                    let mappedOptions = options.map {
                        SubscriptionOptionButtonCore.State(
                            name: $0.name,
                            price: $0.price,
                            isSelected: false
                        )
                    }
                    state.subscriptionOption = SubscriptionOptionCore.State(
                        options: IdentifiedArray(uniqueElements: mappedOptions)
                    )
                case .failure:
                    return .none
                }
                return .none
                
            case .purchaseButtonTapped:
                if let selectedOption = state.subscriptionOption.options.first(where: { $0.isSelected }) {
                    AppLog.log("Purchase button tapped: \(selectedOption.name)")
                } else {
                    AppLog.log("No subscription option selected")
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}
