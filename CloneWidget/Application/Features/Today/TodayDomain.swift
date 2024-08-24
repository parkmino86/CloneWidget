//
//  TodayCore.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct TodayCore {
    
    struct State: Equatable {

    }
    
    enum Action: Equatable {

    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
