//
//  SubscriptionPurchaseView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/22/24.
//

import ComposableArchitecture
import SwiftUI

struct SubscriptionPurchaseView: View {
    let store: StoreOf<SubscriptionPurchaseDomain>
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                SubscriptionOptionView(
                    store: store.scope(
                        state: \.subscriptionOption,
                        action: SubscriptionPurchaseDomain.Action.subscriptionOption
                    )
                )

                Button(action: {
                    store.send(.purchaseButtonTapped)
                }) {
                    Text("구매하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            store.subscriptionOption.selectedOptionID == nil ? Color.gray : Color.blue
                        )
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }
                .disabled(store.subscriptionOption.selectedOptionID == nil)
            }
            .navigationTitle("원하는 인원의 구독권을 선택하세요")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    SubscriptionPurchaseView(
        store: Store(
            initialState: SubscriptionPurchaseDomain.State(),
            reducer: { SubscriptionPurchaseDomain() }
        )
    )
}
