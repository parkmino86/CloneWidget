//
//  CategoryButton.swift
//  CloneWidget
//
//  Created by minoh.park on 8/23/24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - View
struct CategoryButton: View {
    let store: Store<CategoryButtonCore.State, CategoryButtonCore.Action>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text(viewStore.text)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(viewStore.isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(viewStore.isSelected ? Color.white : Color.black)
                .cornerRadius(20)
                .onTapGesture {
                    viewStore.send(.categorySelected)
                }
        }
    }
}

// MARK: - Reducer
@Reducer
struct CategoryButtonCore {
    struct State: Equatable, Identifiable {
        let id: UUID = UUID()
        var text: String
        var isSelected: Bool
    }
    
    enum Action: Equatable {
        case categorySelected
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .categorySelected:
                state.isSelected.toggle()
                return .none
            }
        }
    }
}

// MARK: - Preview
#Preview {
    Group {
        CategoryButton(
            store: Store(
                initialState: CategoryButtonCore.State(text: "Selected Tag", isSelected: true),
                reducer: { CategoryButtonCore() }
            )
        )
        
        CategoryButton(
            store: Store(
                initialState: CategoryButtonCore.State(text: "Unselected Tag", isSelected: false),
                reducer: { CategoryButtonCore() }
            )
        )
    }
}
