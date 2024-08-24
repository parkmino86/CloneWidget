//
//  RootCore.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct RootCore {
    
    enum Tab {
        case today
        case foto
        case explorer
        case myPage
    }
    
    struct State: Equatable {
        var selectedTab = Tab.explorer
        var todayState = TodayCore.State()
        var fotoState = FotoCore.State()
        var explorerState = ExplorerCore.State()
        var myPageState = MyPageCore.State()
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case today(TodayCore.Action)
        case foto(FotoCore.Action)
        case explorer(ExplorerCore.Action)
        case myPage(MyPageCore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .today:
                return .none
            case .foto:
                return .none
            case .explorer:
                return .none
            case .myPage:
                return .none
            }
        }
    }
}
