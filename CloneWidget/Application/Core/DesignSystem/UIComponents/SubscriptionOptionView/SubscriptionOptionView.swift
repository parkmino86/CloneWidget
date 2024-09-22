//
//  SubscriptionOptionView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import ComposableArchitecture
import SwiftUI

// MARK: - View

struct SubscriptionOptionView: View {
    let store: StoreOf<SubscriptionOptionCore>

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEachStore(
                    store.scope(
                        state: \.options,
                        action: SubscriptionOptionCore.Action.subscriptionOption(id:action:))
                ) {
                    SubscriptionOptionButton(store: $0)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Reducer

@Reducer
struct SubscriptionOptionCore {
    @ObservableState
    struct State: Equatable {
        var options: IdentifiedArrayOf<SubscriptionOptionButtonCore.State> = []
        var selectedOptionID: UUID? = nil
    }

    enum Action: Equatable {
        case subscriptionOption(id: UUID, action: SubscriptionOptionButtonCore.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .subscriptionOption(id, .didSelectSubscriptionOption):
                state.selectedOptionID = id
                state.options = IdentifiedArray(
                    uniqueElements: state.options.map { option in
                        var updatedOption = option
                        updatedOption.isSelected = option.id == id
                        return updatedOption
                    }
                )
                return .none
            }
        }
        .forEach(\.options, action: /Action.subscriptionOption(id:action:)) {
            SubscriptionOptionButtonCore()
        }
    }
}

// MARK: - Preview

#Preview {
    SubscriptionOptionView(
        store: Store(
            initialState: SubscriptionOptionCore.State(
                options: [
                    SubscriptionOptionButtonCore.State(name: "Option 1", price: 5500, isSelected: false),
                    SubscriptionOptionButtonCore.State(name: "Option 2", price: 11000, isSelected: true),
                    SubscriptionOptionButtonCore.State(name: "Option 3", price: 16500, isSelected: false),
                ]
            ),
            reducer: { SubscriptionOptionCore() }
        )
    )
}
