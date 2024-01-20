//
//  OpenCoreWalletView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/14/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // 1
    let url: URL

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct OpenCoreWireWalletView: View {
    @State var toPay = false
    
    var body: some View {
        VStack
        {
            HStack{
                Image("Logo")
                Text("OpenCore Wallet")
                    .font(.system(size: 34))
                    .padding(.leading)
            }
            .padding(2.0)
        
            Spacer()
            
            ZStack
            {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.yellow)
                VStack
                {
                    HStack
                    {
                        Text("Метод")
                        Spacer()
                        Text("Подключение тарифа")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    HStack
                    {
                        Text("Тариф")
                        Spacer()
                        Text("OpenCore Wire")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    HStack
                    {
                        Text("Цена")
                        Spacer()
                        Text("94₽")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    HStack
                    {
                        Text("Период")
                        Spacer()
                        Text("1 месяц")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    
                }
                .foregroundColor(.black)
                .padding(.vertical)
            }
            .frame(width: 343, height: 50)
            .transition(.move(edge: .bottom))
            
            Button("Оплатить"){
                toPay.toggle()
            }
            .frame(width: 340, height: 55)
            .font(.system(size: 18))
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(20)
                .padding(.top, 50)
        }
        .fullScreenCover(isPresented: $toPay, content: {
            OpenCoreWireWalletWebLoad()
        })
    }
}

struct OpenCoreWireWalletWebLoad: View {
    
    @State var toApplyPay = false
    
    var body: some View {
        VStack
        {
            LogoComponent()
            ProgressView()
                .onAppear()
            {
                struct ModelRequest: Codable {
                    var token: String
                    var subid: String
                }
                
                let token = UserDefaults.standard.string(forKey: "token")
                
                let model_request = ModelRequest(token: token!, subid: "2")
                
                let request = parametersEncode(endpoint: server+"pay/", object: model_request)!
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    if statusCode == 200 {
                        struct AnswerServer: Codable {
                            var result: String
                            var reason: String?
                            var pay_id: String?
                            var pay_token: String?
                        }
                        let result = String(data: data!, encoding: .utf8) ?? ""
                        let decoder = JSONDecoder()
                        let json = result.data(using: .utf8)!
                        let answer = try! decoder.decode(AnswerServer.self, from: json)
                        
                        print(answer.result)
                        if answer.result == "true"
                        {
                            UserDefaults.standard.set(answer.pay_id!, forKey: "pay_id")
                            UserDefaults.standard.set(answer.pay_token!, forKey: "pay_id")
                        }
                        
                    } else {
                        print("CODE NON SUPPORT OF PROTOCOL")
                    }
                }
                task.resume()
            }
        }
        .fullScreenCover(isPresented: $toApplyPay, content: {
            OpenCoreWireWalletWeb()
        })
    }
    
}


struct OpenCoreWireWalletWeb: View {
    
    @State var showURL = true
    
    var body: some View {
        VStack
        {
            
        }
        
    }
    
}


#Preview {
    OpenCoreWireWalletWeb()
}
