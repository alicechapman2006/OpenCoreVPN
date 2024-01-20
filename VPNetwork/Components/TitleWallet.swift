//
//  TitleWallet.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/14/24.
//

import SwiftUI

struct TitleWallet: View {
    var body: some View {
        VStack
        {
            ZStack{
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray)
                    .frame(width: 300, height: 40)
                VStack
                {
                    Text("Подключение тарифа")
                }
            }
        }
    }
}
