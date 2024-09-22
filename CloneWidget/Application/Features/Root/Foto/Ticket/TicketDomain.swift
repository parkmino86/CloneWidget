//
//  TicketDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 9/9/24.
//

import ComposableArchitecture

@Reducer
struct TicketDomain {
    @Dependency(\.subscriptionPurchaseClient) var subscriptionPurchaseClient

    @ObservableState
    struct State: Equatable {
        var isSubscriptionPurchaseViewPresented: Bool = false
    }

    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case purchaseButtonTapped
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .purchaseButtonTapped:
                state.isSubscriptionPurchaseViewPresented = true
                return .none
            default:
                return .none
            }
        }
    }
}
