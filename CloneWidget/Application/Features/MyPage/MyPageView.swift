//
//  MyPageView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import SwiftUI
import ComposableArchitecture

struct MyPageView: View {
    let store: Store<MyPageCore.State, MyPageCore.Action>
    
    var body: some View {
        Text("My Page View")
    }
}
