//
//  RootDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct RootDomain {
    enum Tab: Equatable, Hashable {
        case today
        case foto
        case explorer
        case myPage
    }

    @ObservableState
    struct State: Equatable {
        var selectedTab = Tab.explorer
        
        var today = TodayDomain.State()
        var foto = FotoDomain.State()
        var explorer = ExplorerDomain.State()
        var myPage = MyPageDomain.State()
                
        var global = LoadingProgressCore.State()
    }

    enum Action: Equatable {
        case tabSelected(Tab)
        
        case today(TodayDomain.Action)
        case foto(FotoDomain.Action)
        case explorer(ExplorerDomain.Action)
        case myPage(MyPageDomain.Action)
        
        case global(LoadingProgressCore.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.foto, action: \.foto) {
            FotoDomain()
        }
        Scope(state: \.global, action: \.global) {
            LoadingProgressCore()
        }
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
                
            case let .foto(action):
                switch action {
                case .showLoading:
                    return .send(.global(.showLoading))
                    
                case .hideLoading:
                    return .send(.global(.hideLoading))
                    
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
    }
}
