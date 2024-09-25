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

    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var artistSelector: CategorySelectorCore.State = .init(categories: IdentifiedArrayOf())
        var artistMembers: IdentifiedArrayOf<ProfileCore.State> = []
        var selectedArtist: String?
    }

    @Reducer
    struct Path: Equatable {
        @ObservableState
        enum State: Equatable {
            case ticket(TicketDomain.State)
            case artist(ArtistDomain.State)
        }

        enum Action: Equatable {
            case ticket(TicketDomain.Action)
            case artist(ArtistDomain.Action)
        }

        var body: some ReducerOf<Self> {
            Scope(state: \.ticket, action: \.ticket) { TicketDomain() }
            Scope(state: \.artist, action: \.artist) { ArtistDomain() }
        }
    }

    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case onAppear
        case fetchArtists
        case fetchArtistsResponse(TaskResult<[CategoryButtonCore.State]>)
        case fetchArtistMembers(String)
        case fetchArtistMembersResponse(TaskResult<[ProfileCore.State]>)

        case howToUseButtonTapped
        case myButtonTapped
        case artistSelector(CategorySelectorCore.Action)
        case artistMember(id: ProfileCore.State.ID, action: ProfileCore.Action)

        case showLoading
        case hideLoading
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
                    do {
                        let artists = try await fotoClient.fetchArtists()
                        await send(.showLoading)
                        await send(.fetchArtistsResponse(.success(artists)))
                        await send(.hideLoading)
                    } catch {
                        await send(.fetchArtistsResponse(.failure(error)))
                    }
                }

            case let .fetchArtistsResponse(result):
                switch result {
                case let .success(artists):
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
                    do {
                        let members = try await fotoClient.fetchArtistMembers(artist)
                        await send(.fetchArtistMembersResponse(.success(members)))
                    } catch {
                        await send(.fetchArtistMembersResponse(.failure(error)))
                    }
                }

            case let .fetchArtistMembersResponse(result):
                switch result {
                case let .success(members):
                    state.artistMembers = IdentifiedArray(uniqueElements: members)
                case .failure:
                    return .none
                }
                return .none

            case .howToUseButtonTapped:
                AppLog.log("How To Use button tapped")
                return .none
                
            case .myButtonTapped:
                AppLog.log("My button tapped")
                state.path.append(.ticket(TicketDomain.State()))
                return .none

            case .artistSelector(.categoryButton(_, .didSelectCategoryButton)):
                guard let selectedCategory = state.artistSelector.categories.first(where: { $0.isSelected }) else {
                    return .none
                }
                state.selectedArtist = selectedCategory.text
                return .send(.fetchArtistMembers(selectedCategory.text))

            case let .artistMember(id, .profileSelected):
                if let selectedMember = state.artistMembers.first(where: { $0.id == id }) {
                    AppLog.log("Artist Member Selected - Name: \(selectedMember.name)")
                    state.path.append(.artist(ArtistDomain.State(name: selectedMember.name, group: selectedMember.group)))
                }
                return .none

            default:
                return .none
            }
        }
        .forEach(\.artistMembers, action: /Action.artistMember(id:action:)) {
            ProfileCore()
        }
        .forEach(\.path, action: \.path) { Path() }
    }
}
