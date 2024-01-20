//
//  FirstTimeView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/11/24.
//

import SwiftUI
import CryptoKit

struct FirstTimeView: View {
    @State var name = ""
    @State var password1 = ""
    @State var toLogin = false
    @State var PH = CryptoKit.SHA256.hash(data: "test".data(using: .utf8)!)
    @State var toReg = false
    
    var body: some View {
        VStack{
            
            LogoComponent()
            
            Text("Авторизация")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .font(.system(size: 24))
            
            TextField("Логин", text: $name)
                .padding(.horizontal, 12.0)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Пароль", text: $password1)
                .padding(.horizontal, 12.0)
                .textFieldStyle(.roundedBorder)
            
            Button("Нет аккаунта в Opencore?")
            {
                toReg.toggle()
            }
            
            Button("Продолжить"){
                if name != "" || password1 != ""
                {
                    let data = password1.data(using: .utf8)!
                    PH = CryptoKit.SHA256.hash(data: data)
                    let digestString = PH.reduce(into: "") { result, byte in
                        result += String(format: "%02x", byte)
                    }
                    
                    RegPass = digestString
                    toLogin.toggle()
                }
                
            }
                .frame(width: 300, height: 40)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
  
            
        }
        .fullScreenCover(isPresented: $toLogin, content: {
            LoginProccess(login1: name)
        })
        .sheet(isPresented: $toReg, content: {
            RegistrationView()
        })
    }
}



#Preview {
    FirstTimeView()
}
