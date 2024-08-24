//
//  FotoView.swift
//  CloneWidget
//
//  Created by minoh.park on 8/15/24.
//

import ComposableArchitecture
import SwiftUI

struct FotoView: View {
    let store: StoreOf<FotoDomain>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
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

                        VStack(alignment: .leading, spacing: 8) {
                            Text("추천 아티스트")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 16)

                            CategorySelectorView(
                                store: store.scope(
                                    state: \.artistSelector,
                                    action: \.artistSelector
                                )
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .navigationBarTitle("foto", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    viewStore.send(.myButtonTapped)
                }) {
                    Text("my")
                        .font(.headline)
                })
            }
        }
    }
}

struct FotoView_Previews: PreviewProvider {
    static var previews: some View {
        FotoView(
            store: Store(
                initialState: FotoDomain.State(),
                reducer: { FotoDomain() }
            )
        )
    }
}
