//
//  RootView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootCore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(
                get: \.selectedTab,
                send: RootCore.Action.tabSelected
            )) {
                TodayView(store: self.store.scope(
                    state: \.todayState,
                    action: \.today)
                    )
                    .tabItem {
                        Label("Today", systemImage: "calendar")
                    }
                    .tag(RootCore.Tab.today)
                
                FotoView(store: self.store.scope(
                    state: \.fotoState,
                    action: \.foto)
                    )
                    .tabItem {
                        Label("Foto", systemImage: "photo")
                    }
                    .tag(RootCore.Tab.foto)
                
                ExplorerView(store: self.store.scope(
                    state: \.explorerState,
                    action: \.explorer)
                    )
                    .tabItem {
                        Label("Explorer", systemImage: "safari")
                    }
                    .tag(RootCore.Tab.explorer)
                
                MyPageView(store: self.store.scope(
                    state: \.myPageState,
                    action: \.myPage)
                    )
                    .tabItem {
                        Label("My Page", systemImage: "person")
                    }
                    .tag(RootCore.Tab.myPage)
            }
        }
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootCore.State(),
        reducer: { RootCore() }
    ))
}
