//
//  TodayView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import SwiftUI
import ComposableArchitecture

struct TodayView: View {
    let store: Store<TodayCore.State, TodayCore.Action>
    
    var body: some View {
        Text("Today View")
    }
}
