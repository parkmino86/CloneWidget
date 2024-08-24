//
//  FotoDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct FotoDomain {
    struct State: Equatable {
        var artistSelector: CategorySelectorDomain.State = .init(
            categories: [
                CategoryButtonCore.State(text: "ATEEZ", isSelected: true),
                CategoryButtonCore.State(text: "BTS", isSelected: false),
                CategoryButtonCore.State(text: "BLACKPINK", isSelected: false),
            ],
            selectedCategory: nil
        )
        var selectedArtist: String?
    }

    enum Action: Equatable {
        case myButtonTapped
        case artistSelector(CategorySelectorDomain.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.artistSelector, action: \.artistSelector) {
            CategorySelectorDomain()
        }
        Reduce { state, action in
            switch action {
            case .myButtonTapped:
                print("My button tapped")
                return .none
            default:
                return .none
            }
        }        
    }
}
