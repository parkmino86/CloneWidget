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
    @Dependency(\.fotoClient) var fotoClient
    
    struct State: Equatable {
        var isLoading: Bool = false
        var errorMessage: String?
        
        var allArtistMembers: [ArtistMemberDomain.State] = []
        var artistSelector: CategorySelectorCore.State = .init(categories: IdentifiedArrayOf())
        var artistMembers: IdentifiedArrayOf<ArtistMemberDomain.State> = []

        var selectedArtistGroup: String?
    }

    enum Action: Equatable {
        case onAppear
        case fetchAllArtistMembers
        case fetchAllArtistMembersResponse(TaskResult<[ArtistMemberDomain.State]>)
        
        case didPressMyButton
        case artistSelector(CategorySelectorCore.Action)
        case artistMember(id: ArtistMemberDomain.State.ID, action: ArtistMemberDomain.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.artistSelector, action: \.artistSelector) {
            CategorySelectorCore()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchAllArtistMembers)

            case .fetchAllArtistMembers:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    await send(.fetchAllArtistMembersResponse(TaskResult {
                        try await fotoClient.fetchMembers()
                    }))
                }
                
            case let .fetchAllArtistMembersResponse(.success(members)):
                state.isLoading = false
                state.allArtistMembers = members

                let uniqueGroups = Set(members.map { $0.group })
                let categories = IdentifiedArray(
                    uniqueElements: uniqueGroups.map { group in
                        CategoryButtonCore.State(text: group, isSelected: group == uniqueGroups.first)
                    }
                )
                state.artistSelector = CategorySelectorCore.State(categories: categories)

                if let firstGroup = uniqueGroups.first {
                    state.selectedArtistGroup = firstGroup
                    state.artistMembers = IdentifiedArray(
                        uniqueElements: members.filter { $0.group == firstGroup }
                    )
                }

                return .none

            case let .fetchAllArtistMembersResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = "Failed to fetch artist members: \(error)"
                return .none

            case .didPressMyButton:
                AppLog.log("My button tapped")
                return .none
                
            case .artistSelector(.categoryButton(_, .didSelectCategoryButton)):
                guard let selectedCategory = state.artistSelector.categories.first(where: { $0.isSelected }) else {
                    return .none
                }
                state.selectedArtistGroup = selectedCategory.text
                state.artistMembers = IdentifiedArray(uniqueElements: state.allArtistMembers.filter { member in
                    member.group == selectedCategory.text
                })
                return .none

            case let .artistMember(id, action):
                AppLog.log("Artist Member Action - ID: \(id), Action: \(action)")
                return .none
            }
        }
        .forEach(\.artistMembers, action: /Action.artistMember(id:action:)) {
            ArtistMemberDomain()
        }
    }
}
