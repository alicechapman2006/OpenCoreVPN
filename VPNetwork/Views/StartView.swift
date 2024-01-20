//
//  ContentView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/10/24.
//

import SwiftUI

var server = "https://api.skidblandir.ru/"
var RegPass = ""

struct StartView: View {
    
    @State var FirstXds = false
    @State var ProfileV = false
    
    var body: some View {
        VStack {
            Image("Logo")
                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
            Text("Opencore")
                .padding(.bottom, 30.0)
                .onAppear(){
                    if (UserDefaults.standard.string(forKey: "token") != nil)
                    {
                        ProfileV.toggle()
                        
                    }
                    else
                    {
                        FirstXds.toggle()
                    }
                }
            
            
        }
        .fullScreenCover(isPresented: $FirstXds, content: {
            FirstTimeView()
        })
        .fullScreenCover(isPresented: $ProfileV, content: {
            LoadProfile()
        })
        .padding()
        
        
    }
}

#Preview {
    StartView()
}
