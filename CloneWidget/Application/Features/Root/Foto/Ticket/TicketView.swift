//
//  TicketView.swift
//  CloneWidget
//
//  Created by minoh.park on 9/9/24.
//

import ComposableArchitecture
import SwiftUI

struct TicketView: View {
    var store: StoreOf<TicketDomain>
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("이용 중인 티켓이 없습니다.")
                .font(.title3)
        }
        .navigationBarTitle("나의 티켓", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton {
            presentationMode.wrappedValue.dismiss()
        })
    }
}
