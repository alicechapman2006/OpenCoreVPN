//
//  LogoComponent.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/11/24.
//

import SwiftUI

struct LogoComponent: View {
    var body: some View {
        HStack{
            Image("Logo")
            Text("OpenCore VPN")
                .font(.system(size: 36))
                .padding(.leading)
        }
        .padding(2.0)
    }
}
