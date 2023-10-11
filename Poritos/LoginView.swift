//
//  StartView.swift
//  Poritos
//
//  Created by Gerson Lima on 23/09/23.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var SignUpScreen = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var destinationLabelB = "Entrar"
    
    var body: some View {
        NavigationStack {
            NavigationView {
                ZStack {
                    Color("BGColor").ignoresSafeArea()
                    ScrollView {
                        VStack {
                            Image("Icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                                .padding(.top, 80)
                            
                            Spacer().frame(height: 40)
                            
                            TextField("", text: $email, prompt: Text("E-mail").foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.8)))
                                .foregroundColor(Color.black)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            Spacer().frame(height: 20)
                            
                            SecureTextField(text: $password, placeholder: "Senha")
                                .foregroundColor(Color.black)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            Spacer().frame(height: 10)
                            
                            Button(action: {}) {
                                Text("Esqueci minha senha")
                                    .underline()
                                    .foregroundColor(Color(.gray))
                                    .font(Font.system(size: 16, weight: .regular))
                                    .padding(.leading, 160)
                            }
                            
                            Spacer().frame(height: 60)
                            
                            NavigationLink(destination: ContentHome()) {
                                Text(destinationLabelB)
                                    .foregroundColor(Color(.white))
                                    .font(Font.system(size: 26, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(16)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("PrimaryColor"))
                                    .cornerRadius(10)
                                    .frame(maxHeight: 60)
                            }
                            
                            Spacer().frame(height: 20)
                            
                                .sheet(isPresented: $SignUpScreen) {
                                    SignUpView()
                                }
                            
                            HStack{
                                Text("Ainda não tem uma conta?")
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(Color.gray)
                                Button(action: {SignUpScreen = true}) {
                                    Text("Crie uma!")
                                        .underline()
                                        .foregroundColor(Color("PrimaryColor"))
                                        .font(Font.system(size: 16, weight: .regular))
                                }
                                
                            }.padding(20)
                        }.padding(30)
                    }
                }
            }.onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}

