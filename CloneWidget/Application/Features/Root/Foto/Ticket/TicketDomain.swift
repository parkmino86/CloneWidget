//
//  TicketDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 9/9/24.
//

import ComposableArchitecture

@Reducer
struct TicketDomain {    
    @ObservableState
    struct State: Equatable {}

    enum Action: Equatable {}

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            .none
        }
    }
}
