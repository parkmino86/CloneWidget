//
//  ProfileView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/24/24.
//

import ComposableArchitecture
import SwiftUI

struct ProfileView: View {
    var store: StoreOf<ProfileCore>

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
    ProfileView(
        store: Store(
            initialState: ProfileCore.State(name: "Hongjoong", group: "ATEEZ"),
            reducer: { ProfileCore() }
        )
    )
}
