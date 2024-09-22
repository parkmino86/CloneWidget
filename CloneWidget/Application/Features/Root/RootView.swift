//
//  RootView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    @Bindable var store: StoreOf<RootDomain>

    var body: some View {
        ZStack {
            TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
                TodayView(store: self.store.scope(
                    state: \.today,
                    action: \.today
                )
                )
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
                .tag(RootDomain.Tab.today)

                FotoView(store: self.store.scope(
                    state: \.foto,
                    action: \.foto
                )
                )
                .tabItem {
                    Label("Foto", systemImage: "photo")
                }
                .tag(RootDomain.Tab.foto)

                ExplorerView(store: self.store.scope(
                    state: \.explorer,
                    action: \.explorer
                )
                )
                .tabItem {
                    Label("Explorer", systemImage: "safari")
                }
                .tag(RootDomain.Tab.explorer)

                MyPageView(store: self.store.scope(
                    state: \.myPage,
                    action: \.myPage
                )
                )
                .tabItem {
                    Label("My Page", systemImage: "person")
                }
                .tag(RootDomain.Tab.myPage)
            }

            LoadingProgressView(store: self.store.scope(
                state: \.global,
                action: \.global
            )
            )
        }
    }
}

#Preview {
    RootView(store: Store(
        initialState: RootDomain.State(),
        reducer: { RootDomain() }
    ))
}
