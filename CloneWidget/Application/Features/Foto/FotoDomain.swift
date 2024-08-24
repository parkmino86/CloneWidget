//
//  FotoCore.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct FotoCore {
    
    struct State: Equatable {
        var recommendedArtists: [String] = ["ATEEZ", "BTS", "BLACKPINK"]
        var selectedArtist: String? = nil
    }
    
    enum Action: Equatable {
        case artistSelected(String)
        case myButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .artistSelected(artist):
                state.selectedArtist = artist
                return .none
                
            case .myButtonTapped:
                print("My button tapped")
                return .none
            }
        }
    }
}
