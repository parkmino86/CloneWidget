//
//  CloneWidgetApp.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct CloneWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(
                initialState: RootDomain.State(),
                reducer: { RootDomain() }
            ))
        }
    }
}
