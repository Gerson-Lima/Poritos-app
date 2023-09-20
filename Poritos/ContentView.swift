//
//  ContentView.swift
//  Poritos
//
//  Created by Gerson Lima on 18/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var SignUpScreen = false
    
    var body: some View {
        
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            
            VStack{
                ZStack{
                    Image("BackgroundImage")
                        .resizable()
                    Image("LogoName")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(70)
                        .padding(.bottom, 100)
                }
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color("SecundaryColor"))
                        .shadow(color: .black.opacity(0.25), radius: 75)
                    VStack{
                    Image("Slogan")
                            .padding(.bottom, 100)
                        Button(action: {}) {
                            Text("Entrar")
                                .font(Font.system(size: 26, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.30, green: 0.49, blue: 0.73))
                                .cornerRadius(10)
                                .frame(width: 250, height: 60)
                        }
                        .sheet(isPresented: $SignUpScreen) {
                            LoginView()
                        }
                        .padding()
                        HStack{
                            Text("Ainda não tem uma conta?")
                                .font(Font.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0.24, green: 0.34, blue: 0.48))
                            Button(action: {SignUpScreen = true}) {
                                Text("Crie uma!")
                                    .underline()
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 16, weight: .semibold))
                            }
                        }
                    }
                }
            }
            Image("dog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(30)
                .padding(.bottom, 130)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
