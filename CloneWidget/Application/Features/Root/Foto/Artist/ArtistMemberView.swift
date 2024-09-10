//
//  ArtistMemberView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/24/24.
//

import ComposableArchitecture
import SwiftUI

struct ArtistMemberView: View {
    var store: StoreOf<ArtistMemberDomain>

    var body: some View {
        VStack {
            Image(systemName: "person.crop.square")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(store.name)
                .font(.footnote)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            store.send(.profileSelected)
        }
    }
}

#Preview {
    ArtistMemberView(
        store: Store(
            initialState: ArtistMemberDomain.State(name: "Hongjoong", group: "ATEEZ"),
            reducer: { ArtistMemberDomain() }
        )
    )
}
