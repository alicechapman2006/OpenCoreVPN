//
//  TarifsView.swift
//  VPNetwork
//
//  Created by Алиса Владимировна on 1/14/24.
//

import SwiftUI

struct TarifsView: View {
    @State var toWalletWire = false
    
    var body: some View {
        
            VStack {
                LogoComponent()
                Text("Тарифные планы")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                
                ScrollView
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.indigo)
                        
                        VStack {
                            
                            HStack
                            {
                                Text("OpenCore Wire")
                                    .font(.system(size: 24))
                                    .bold()
                                Spacer()
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            
                            HStack()
                            {
                                Text("Количество стран")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("3")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            
                            HStack()
                            {
                                Text("Максимальная скорость")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("4мб/сек")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            HStack()
                            {
                                Text("Цена")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("94₽")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            
                            Button("Подробнее"){
                                toWalletWire.toggle()
                            }
                                .frame(width: 350, height: 55)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.top)
                                .padding(.bottom, 20)
                            
                            
                            
                        }
                        .padding(.top)
                        .padding(.horizontal, 19.0)
                        
                        
                    }
                    .frame(height: 250)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 15)
                    .padding(.top, 10)
                    
                    
                    
                    
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray.secondary)
                        
                        VStack{
                            
                            HStack
                            {
                                Text("OpenCore Start")
                                    .font(.system(size: 24))
                                    .bold()
                                Spacer()
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            
                            HStack()
                            {
                                Text("Количество стран")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("1")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            
                            HStack()
                            {
                                Text("Максимальная скорость")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("2мб/сек")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            HStack()
                            {
                                Text("Цена")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("76₽")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            
                            Button("Подробнее"){
                            }
                                .frame(width: 350, height: 55)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(.top)
                                .padding(.bottom, 20)
                            
                            
                            
                        }
                        .padding(.top)
                        .padding(.horizontal, 19.0)
                        
                        
                    }
                    .frame(height: 250)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 15)
                    .padding(.top, 10)
                    
                    
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray.secondary)
                        
                        VStack{
                            
                            HStack
                            {
                                Text("OpenCore Unlimited")
                                    .font(.system(size: 24))
                                    .bold()
                                Spacer()
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            
                            HStack()
                            {
                                Text("Количество стран")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("7")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            
                            HStack()
                            {
                                Text("Максимальная скорость")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("∞ мб/сек")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            .padding(.bottom, 1)
                            
                            HStack()
                            {
                                Text("Цена")
                                    .font(.system(size: 19))
                                Spacer()
                                Text("172₽")
                                    .font(.system(size: 19))
                                    .bold()
                            }
                            
                            Button("Подробнее"){
                            }
                                .frame(width: 350, height: 55)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .background(Color.gray.secondary)
                                .cornerRadius(10)
                                .padding(.top)
                                .padding(.bottom, 20)
                            
                        }
                        .padding(.top)
                        .padding(.horizontal, 19.0)
                        
                        
                    }
                    .frame(height: 250)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 15)
                    .padding(.top, 10)
                    
                    
                    
                    
                    
                    
                }
            }
            .sheet(isPresented: $toWalletWire) {
                OpenCoreWireWalletView()
            }
            
    }
}

#Preview {
    TarifsView()
}
