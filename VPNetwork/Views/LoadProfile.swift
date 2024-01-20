//
//  SwiftUIView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/12/24.
//

import SwiftUI

func parametersEncode(endpoint: String, object: Codable) -> URLRequest? {
       guard let url = URL(string: endpoint) else {
           return nil
       }


       guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
           return nil
       }

       if let dict = object.dictionary {
           components.queryItems = dict.map { dict in
               URLQueryItem(name: dict.key, value: "\(dict.value)")
           }
       }

       guard let url = components.url else {
          return nil
       }

       var request: URLRequest = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

       if let query = components.url?.query(percentEncoded: true),
           let data = query.data(using: .utf8, allowLossyConversion: true) {
           request.httpBody = data
       }

       return request
   }



struct LoadProfile: View {
    
    @State var tokenLoad = ""
    @State var toProfile = false
    var username = ""
    var token = ""
    
    
    
    var body: some View {
        VStack
        {
            LogoComponent()
            Text("Загрузка профиля")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ProgressView()
                .onAppear()
            {
                if let loadedString = UserDefaults.standard.string(forKey: "token")
                {
                    tokenLoad = loadedString
                }
                struct ModelRequest: Codable {
                    var token: String
                }
                
                let model_request = ModelRequest(token: tokenLoad)
                
                let request = parametersEncode(endpoint: server+"getUser/", object: model_request)!
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    if statusCode == 200 {
                        struct AnswerServer: Codable {
                            var result: String
                            var reason: String?
                            var username: String?
                            var token: String?
                            var vpn_subscribe: String?
                        }
                        let result = String(data: data!, encoding: .utf8) ?? ""
                        let decoder = JSONDecoder()
                        let json = result.data(using: .utf8)!
                        let answer = try! decoder.decode(AnswerServer.self, from: json)
                        
                        print(answer.result)
                        if answer.result == "true"
                        {
                            UserDefaults.standard.set(answer.username!, forKey: "login")
                            UserDefaults.standard.set(answer.vpn_subscribe!, forKey: "vpn_subscribe")
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
            ProfileView()
        })
    }
}

#Preview {
    LoadProfile()
}
