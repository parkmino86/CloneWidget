//
//  FotoView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture
import SwiftUI

struct FotoView: View {
    @Bindable var store: StoreOf<FotoDomain>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("아티스트 사진구독")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 16)

                        Text("foto")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("foto는 아티스트의 독점 미공개 사진을 구독하고, 구독한 사진으로 자유롭게 폰꾸미기를 할 수 있는 특별한 서비스입니다.")
                            .font(.body)
                            .padding(.top, 8)

                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.yellow)
                            Text("사진이 전송되는 시점에 구독 상태여야 받을 수 있어요!")
                                .font(.callout)
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("구독 혜택")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)

                        Text("① 아티스트 별 미공개 사진 매주 1회 제공")
                            .font(.body)

                        Text("② 폰꾸미기 무제한 이용")
                            .font(.body)

                        Text("③ 포토위젯 광고 제거")
                            .font(.body)
                    }
                    .padding(.horizontal, 16)
                    
                    LazyVStack(alignment: .leading, spacing: 8, pinnedViews: [.sectionHeaders]) {
                        Section(content: {
                            CategorySelectorView(
                                store: store.scope(
                                    state: \.artistSelector,
                                    action: \.artistSelector
                                )
                            )
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),
                                      spacing: 16) {
                                ForEachStore(
                                    store.scope(
                                        state: \.artistMembers,
                                        action: \.artistMember
                                    )
                                ) { artistMemberStore in
                                    ProfileView(store: artistMemberStore)
                                }
                            }
                        },
                        header: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("추천 아티스트")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top, 16)
                                    .padding(.bottom, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .background(.background)
                        })
                    }
                }
                .padding(.horizontal, 16)
                .onAppear {
                    store.send(.onAppear)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("foto")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        store.send(.didPressMyButton)
                    }) {
                        Text("my")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            
        } destination: { store in
            switch store.state {
            case .ticket:
                if let store = store.scope(state: \.ticket, action: \.ticket) {
                    TicketView(store: store)
                }
            case .artist:
                if let store = store.scope(state: \.artist, action: \.artist) {
                    ArtistView(store: store)
                }
            }
        }
    }
}

#Preview {
    FotoView(
        store: Store(
            initialState: FotoDomain.State(),
            reducer: {
                FotoDomain()
                    .dependency(\.fotoClient, .previewValue)
            }
        )
    )
}
