//
//  RootDomain.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture

@Reducer
struct RootDomain {
    enum Tab {
        case today
        case foto
        case explorer
        case myPage
    }

    struct State: Equatable {
        var selectedTab = Tab.explorer
        var today = TodayDomain.State()
        var foto = FotoDomain.State()
        var explorer = ExplorerDomain.State()
        var myPage = MyPageDomain.State()
    }

    enum Action: Equatable {
        case tabSelected(Tab)
        case today(TodayDomain.Action)
        case foto(FotoDomain.Action)
        case explorer(ExplorerDomain.Action)
        case myPage(MyPageDomain.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.foto, action: \.foto) {
            FotoDomain()
          }
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            default:
                return .none
            }
        }
    }

}
