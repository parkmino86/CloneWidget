//
//  TicketView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/9/24.
//

import ComposableArchitecture
import SwiftUI

struct TicketView: View {
    @Bindable var store: StoreOf<TicketDomain>
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()

            Text("이용 중인 티켓이 없습니다.")

            Spacer()

            Button(action: {
                store.send(.purchaseButtonTapped)
            }) {
                Text("구독권 구매하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
            }
            .sheet(
                isPresented: $store.isSubscriptionPurchaseViewPresented
            ) {
                SubscriptionPurchaseView(
                    store: Store(
                        initialState: SubscriptionPurchaseDomain.State(),
                        reducer: { SubscriptionPurchaseDomain() }
                    )
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
        }
        .padding(.bottom, 20)
        .navigationBarTitle("나의 티켓", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton {
            dismiss()
        })
    }
}

#Preview {
    TicketView(
        store: Store(
            initialState: TicketDomain.State(),
            reducer: {
                TicketDomain()
            }
        )
    )
}
