//
//  ArtistMemberDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 8/24/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArtistMemberDomain {
    @ObservableState
    struct State: Identifiable, Equatable {
        let id: UUID
        var name: String
        var group: String

        init(id: UUID = UUID(), name: String, group: String) {
            self.id = id
            self.name = name
            self.group = group
        }
    }

    enum Action: Equatable {
        case profileSelected
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .profileSelected:
                AppLog.log("Selected profile: \(state.name)")
                return .none
            }
        }
    }
}
