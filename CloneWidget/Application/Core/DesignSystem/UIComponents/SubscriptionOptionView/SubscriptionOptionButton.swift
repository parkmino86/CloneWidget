//
//  SubscriptionOptionButton.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import ComposableArchitecture
import SwiftUI

// MARK: - View

struct SubscriptionOptionButton: View {
    let store: StoreOf<SubscriptionOptionButtonCore>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                Image(systemName: viewStore.isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(viewStore.isSelected ? .blue : .gray)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(viewStore.name)
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    Text("\(viewStore.price, specifier: "%.0f")원 / 월")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            .background(viewStore.isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
            .foregroundColor(viewStore.isSelected ? Color.blue : Color.black)
            .cornerRadius(10)
            .onTapGesture {
                viewStore.send(.didSelectSubscriptionOption)
            }
        }
    }
}

// MARK: - Reducer

@Reducer
struct SubscriptionOptionButtonCore {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID = .init()
        var name: String
        var price: Double
        var isSelected: Bool
    }

    enum Action: Equatable {
        case didSelectSubscriptionOption
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didSelectSubscriptionOption:
                state.isSelected.toggle()
                return .none
            }
        }
    }
}

// MARK: - Preview

#Preview {
    Group {
        SubscriptionOptionButton(
            store: Store(
                initialState: SubscriptionOptionButtonCore.State(name: "Selected Option", price: 5500, isSelected: true),
                reducer: { SubscriptionOptionButtonCore() }
            )
        )

        SubscriptionOptionButton(
            store: Store(
                initialState: SubscriptionOptionButtonCore.State(name: "Unselected Option", price: 11000, isSelected: false),
                reducer: { SubscriptionOptionButtonCore() }
            )
        )
    }
}
