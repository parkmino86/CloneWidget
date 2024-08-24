//
//  ExplorerView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import SwiftUI
import ComposableArchitecture

struct ExplorerView: View {
    let store: Store<ExplorerCore.State, ExplorerCore.Action>
    
    var body: some View {
        Text("Explorer View")
    }
}
