//
//  ArtistView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/11/24.
//

import ComposableArchitecture
import SwiftUI

struct ArtistView: View {
    @Bindable var store: StoreOf<ArtistDomain>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("\(store.name)")
                .font(.title3)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton {
            dismiss()
        })
    }
}

#Preview {
    ArtistView(
        store: Store(
            initialState: ArtistDomain.State(name: "Hongjoong", group: "ATEEZ"),
            reducer: { ArtistDomain() }
        )
    )
}
