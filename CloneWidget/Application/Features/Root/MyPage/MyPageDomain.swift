//
//  MyPageDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct MyPageDomain {
    @ObservableState
    struct State: Equatable {}

    enum Action: Equatable {}

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            .none
        }
    }
}
