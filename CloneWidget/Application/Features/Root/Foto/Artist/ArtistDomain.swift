//
//  ArtistDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 9/12/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArtistDomain {
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

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .profileSelected:
                AppLog.log("Selected profile: \(state.name)")
                return .none
            }
        }
    }
}
