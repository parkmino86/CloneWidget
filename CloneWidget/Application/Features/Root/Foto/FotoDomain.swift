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
    @Dependency(\.loadingClient) var loadingClient

    struct State: Equatable {
        var artistSelector: CategorySelectorCore.State = .init(categories: IdentifiedArrayOf())
        var artistMembers: IdentifiedArrayOf<ArtistMemberDomain.State> = []
        var selectedArtist: String?
    }

    enum Action: Equatable {
        case onAppear
        case fetchArtists
        case fetchArtistsResponse(TaskResult<[CategoryButtonCore.State]>)
        case fetchArtistMembers(String)
        case fetchArtistMembersResponse(TaskResult<[ArtistMemberDomain.State]>)

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
                if state.artistSelector.categories.isEmpty {
                    return .send(.fetchArtists)
                }
                return .none

            case .fetchArtists:
                return .run { send in
                    await loadingClient.show()
                    do {
                        let artists = try await fotoClient.fetchArtists()
                        await send(.fetchArtistsResponse(.success(artists)))
                    } catch {
                        await send(.fetchArtistsResponse(.failure(error)))
                    }
                    await loadingClient.hide()
                }

            case let .fetchArtistsResponse(result):
                switch result {
                case .success(let artists):
                    state.artistSelector = CategorySelectorCore.State(
                        categories: IdentifiedArray(uniqueElements: artists)
                    )
                    if let firstArtist = artists.first?.text {
                        state.selectedArtist = firstArtist
                        return .send(.fetchArtistMembers(firstArtist))
                    }
                case .failure:
                    return .none
                }
                return .none

            case let .fetchArtistMembers(artist):
                return .run { send in
                    await loadingClient.show()
                    do {
                        let members = try await fotoClient.fetchMembers(artist)
                        await send(.fetchArtistMembersResponse(.success(members)))
                    } catch {
                        await send(.fetchArtistMembersResponse(.failure(error)))
                    }
                    await loadingClient.hide()
                }

            case let .fetchArtistMembersResponse(result):
                switch result {
                case .success(let members):
                    state.artistMembers = IdentifiedArray(uniqueElements: members)
                case .failure:
                    return .none
                }
                return .none

            case .didPressMyButton:
                AppLog.log("My button tapped")
                return .none

            case .artistSelector(.categoryButton(_, .didSelectCategoryButton)):
                guard let selectedCategory = state.artistSelector.categories.first(where: { $0.isSelected }) else {
                    return .none
                }
                state.selectedArtist = selectedCategory.text
                return .send(.fetchArtistMembers(selectedCategory.text))

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
