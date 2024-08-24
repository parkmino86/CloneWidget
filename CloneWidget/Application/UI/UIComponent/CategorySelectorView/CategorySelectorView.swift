//
//  CategorySelectorView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/23/24.
//

import ComposableArchitecture
import SwiftUI

// MARK: - View

struct CategorySelectorView: View {
    let store: StoreOf<CategorySelectorCore>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { _ in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEachStore(
                        self.store.scope(state: \.categories, action: \.categoryButton)
                    ) { childStore in
                        CategoryButton(store: childStore)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Reducer

@Reducer
struct CategorySelectorCore {
    struct State: Equatable {
        var categories: IdentifiedArrayOf<CategoryButtonCore.State>
    }

    enum Action: Equatable {
        case categoryButton(id: UUID, action: CategoryButtonCore.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .categoryButton(id, .didSelectCategoryButton):
                state.categories = IdentifiedArray(
                    uniqueElements: state.categories.map { category in
                        var updatedCategory = category
                        updatedCategory.isSelected = category.id == id
                        return updatedCategory
                    }
                )
                return .none
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CategorySelectorView(
        store: Store(
            initialState: CategorySelectorCore.State(
                categories: [
                    CategoryButtonCore.State(text: "Category 1", isSelected: true),
                    CategoryButtonCore.State(text: "Category 2", isSelected: false),
                    CategoryButtonCore.State(text: "Category 3", isSelected: false),
                ]
            ),
            reducer: { CategorySelectorCore() }
        )
    )
}
