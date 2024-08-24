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
    let store: StoreOf<CategorySelectorDomain>

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
struct CategorySelectorDomain {
    struct State: Equatable {
        var categories: IdentifiedArrayOf<CategoryButtonCore.State>
        var selectedCategory: String?
    }

    enum Action: Equatable {
        case categorySelected(String)
        case categoryButton(id: UUID, action: CategoryButtonCore.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .categorySelected(categoryText):
                state.categories = IdentifiedArray(
                    uniqueElements: state.categories.map { category in
                        var updatedCategory = category
                        updatedCategory.isSelected = category.text == categoryText
                        return updatedCategory
                    }
                )
                state.selectedCategory = categoryText
                return .none

            case let .categoryButton(id, .categorySelected):
                state.categories = IdentifiedArray(
                    uniqueElements: state.categories.map { category in
                        var updatedCategory = category
                        updatedCategory.isSelected = category.id == id
                        return updatedCategory
                    }
                )
                state.selectedCategory = state.categories.first(where: { $0.id == id })?.text
                return .none
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CategorySelectorView(
        store: Store(
            initialState: CategorySelectorDomain.State(
                categories: [
                    CategoryButtonCore.State(text: "Category 1", isSelected: true),
                    CategoryButtonCore.State(text: "Category 2", isSelected: false),
                    CategoryButtonCore.State(text: "Category 3", isSelected: false),
                ],
                selectedCategory: nil
            ),
            reducer: { CategorySelectorDomain() }
        )
    )
}
