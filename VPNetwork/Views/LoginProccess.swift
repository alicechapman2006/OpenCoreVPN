//
//  SwiftUIView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/11/24.
//

import SwiftUI
import CryptoKit

struct LoginProccess: View {
    var login = ""
    @State var toProfile = false
    
    init(login1: String)
    {
        login = login1
    }
    
    var body: some View {
        VStack
        {
            LogoComponent()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear()
            {
                struct ModelRequest: Codable {
                    var login: String
                    var password: String
                }
                
                let model_request = ModelRequest(login: login, password: RegPass)
                
                let request = parametersEncode(endpoint: server+"login/", object: model_request)!
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    if statusCode == 200 {
                        struct AnswerServer: Codable {
                            var result: String
                            var reason: String?
                            var token: String?
                        }
                        let result = String(data: data!, encoding: .utf8) ?? ""
                        print(result)
                        let decoder = JSONDecoder()
                        let json = result.data(using: .utf8)!
                        let answer = try! decoder.decode(AnswerServer.self, from: json)
                        
                        print(answer.result)
                        if answer.result == "true"
                        {
                            UserDefaults.standard.set(answer.token!, forKey: "token")
                            toProfile.toggle()
                            
                        } else
                        {
                            
                        }
                        
                    } else {
                        print("CODE NON SUPPORT OF PROTOCOL")
                    }
                }
                task.resume()
                
            }
            
        }.fullScreenCover(isPresented: $toProfile, content: {
            StartView()
        })
    }
}

