//
//  ProfileView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/12/24.
//

import SwiftUI


struct ProfileView: View {
    
    @State var userName = ""
    @State var ExitProfile = false
    
    var body: some View {
        NavigationView {
            VStack
            {
                LogoComponent()
                    .onAppear()
                {
                    if let loadedString = UserDefaults.standard.string(forKey: "login")
                    {
                        userName = loadedString
                    }
                }
                
                
                HStack
                {
                    Image("User")
                    Text(userName)
                        .font(Font.custom("Papyrus", size: 22))
                }
                
                let subscribe = UserDefaults.standard.string(forKey: "vpn_subscribe")
                
                
                Image("Earth")
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                
                if subscribe == "0"
                {
                    NavigationLink("Выбрать тариф", destination: {
                        TarifsView()
                    })
                    .frame(width: 180, height: 40)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top)
                }
                
                Button("Включить VPN"){
                }
                .frame(width: 300, height: 40)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.gray.secondary)
                .cornerRadius(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Button("Выйти")
                {
                    UserDefaults.standard.set(nil, forKey: "token")
                    ExitProfile.toggle()
                }
                .font(.system(size: 21))
                .padding()
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .fullScreenCover(isPresented: $ExitProfile, content: {
                StartView()
            })
        }
    }
}

#Preview {
    ProfileView()
}
