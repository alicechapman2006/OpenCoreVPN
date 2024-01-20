//
//  RegistrationView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/11/24.
//

import SwiftUI
import CryptoKit

struct RegistrationView: View {
    
    @State var login = ""
    @State var setPass = false
    
    var body: some View {
        VStack{
            LogoComponent()
            Text("Регистрация")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .font(.system(size: 24))
            
            TextField("Придумайте ваш никнейм", text: $login)
                .padding(.horizontal, 12.0)
                .textFieldStyle(.roundedBorder)
            
            Button("Продолжить"){
                if login != "" {
                    setPass.toggle()
                }
            }
                .frame(width: 300, height: 40)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }.sheet(isPresented: $setPass, content: {
            RegistrationPasswordView(login1: login)
        })
    }
}

struct RegistrationPasswordView: View {
    
    @State var password = ""
    @State var SamePassword = ""
    var login: String
    @State var PH = CryptoKit.SHA256.hash(data: "test".data(using: .utf8)!)
    @State var StartProcess = false
    
    init(login1: String)
    {
        login = login1
    }
    
    var body: some View {
        VStack{
            LogoComponent()
            Text("Регистрация")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .font(.system(size: 24))
            
            SecureField("Придумайте ваш пароль", text: $password)
                .padding(.horizontal, 12.0)
                .textFieldStyle(.roundedBorder)
            SecureField("Повторите пароль", text: $SamePassword)
                .padding(.horizontal, 12.0)
                .textFieldStyle(.roundedBorder)
            
            Button("Продолжить"){
                if password != "" {
                    if password == SamePassword
                    {
                        let data = password.data(using: .utf8)!
                        PH = CryptoKit.SHA256.hash(data: data)
                        let digestString = PH.reduce(into: "") { result, byte in
                            result += String(format: "%02x", byte)
                        }
                        
                        RegPass = digestString
                        StartProcess.toggle()
                    }
                }
            }
                .frame(width: 300, height: 40)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .fullScreenCover(isPresented: $StartProcess, content: {
            RegistrationProcessView(login1: login)
        })
    }
}

struct RegistrationProcessView: View {
    
    var login = ""
    
    init(login1: String)
    {
        login = login1
    }
    
    
    struct APIData{
        var result: String
        var reason: String?
        var token: String?
    }
    
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
    
    
    @State var toMain = false
    @State var toError = false
    
    var body: some View {
        VStack{
            LogoComponent()
            Text("Создаем аккаунт")
                .font(.system(size: 24))
            Text("Это займет не более секунды")
                .font(.system(size: 22))
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear(){
                    struct ModelRequest: Codable {
                        var login: String
                        var password: String
                    }
                    
                    let model_request = ModelRequest(login: login, password: RegPass)
                    
                    let request = parametersEncode(endpoint: server+"reg/", object: model_request)!
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        let statusCode = (response as! HTTPURLResponse).statusCode

                        if statusCode == 200 {
                            struct AnswerServer: Codable {
                                var result: String
                                var reason: String?
                                var token: String?
                            }
                            let result = String(data: data!, encoding: .utf8) ?? ""
                            let decoder = JSONDecoder()
                            let json = result.data(using: .utf8)!
                            let answer = try! decoder.decode(AnswerServer.self, from: json)
                            
                            if answer.result == "true"
                            {
                                UserDefaults.standard.set(answer.token!, forKey: "token")
                                    toMain.toggle()
                            
                            } else
                            {
                                toError.toggle()
                            }
                            
                        } else {
                            print("CODE NON SUPPORT OF PROTOCOL")
                        }
                    }
                    task.resume()
                }
        }.fullScreenCover(isPresented: $toMain, content: {
            StartView()
        })
        .fullScreenCover(isPresented: $toError, content: {
            ErrorReg()
        })
    }
}

struct ErrorReg: View {
    
    @State var toReg = false
    
    var body: some View {
        VStack
        {
            LogoComponent()
            Text("Такой логин уже есть в системе")
                .font(.system(size: 24))
            
            Button("Понятно"){
                toReg.toggle()
            }
                .frame(width: 300, height: 40)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }.fullScreenCover(isPresented: $toReg, content: {
            StartView()
        })
    }
}

#Preview {
    RegistrationView()
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

