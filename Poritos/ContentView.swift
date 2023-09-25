//
//  ContentView.swift
//  Poritos
//
//  Created by Gerson Lima on 18/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var SignUpScreen = false
    @State private var destinationLabelA = "Iniciar"
    
    var body: some View {
        NavigationStack {
        NavigationView {
            ZStack {
                Color("BGColor").ignoresSafeArea()
                
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
                            .background(Color("PrimaryColor"))
                            .shadow(color: .black.opacity(0.25), radius: 75)
                        VStack{
                            Image("Slogan")
                                .padding(.bottom, 100)
                            
                            NavigationLink(destination: LoginView()) {
                                    Text(destinationLabelA)
                                        .foregroundColor((Color(red: 0, green: 0.49, blue: 1.04)))
                                        .font(Font.system(size: 26, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(16)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .frame(width: 250, height: 60)
                                }
//                                .navigationBarTitle("Entrar", displayMode: .inline)
//                                .navigationBarHidden(true)
                            
                            
                            .sheet(isPresented: $SignUpScreen) {
                                SignUpView()
                            }
                            
                            .padding()
                            HStack{
                                Text("Ainda não tem uma conta?")
                                    .font(Font.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.white)
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
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
