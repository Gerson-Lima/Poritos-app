//
//  ContentView.swift
//  Poritos
//
//  Created by Gerson Lima on 18/09/23.
//
import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentation
    @State private var name: String = ""
    @State private var birth: Date = Date()
    @State private var CPF: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var responseText = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("BGColor").ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Rectangle().frame(width: 40, height: 5)
                            .foregroundColor(.gray)
                            .cornerRadius(3.0)
                            .padding(.bottom, 40)
                            .opacity(0.5)
                        
                        Button(action:{
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Label("Back", systemImage: "chevron.left")
                        }).padding(.trailing, 285)
                            .padding(.top, 40)
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .padding(.top, 40)

                    }
                    
                    ScrollView(showsIndicators: false){
                        
                        Spacer().frame(height: 12)
                        
                        TextField("", text: $name, prompt: Text("Nome").foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.8)))
                            .foregroundColor(Color.black)
                            .autocapitalization(.none)
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .padding(.horizontal)
                            .frame(maxHeight: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Spacer().frame(height: 20)
                        
                        DatePicker("Data de nascimento:", selection: $birth, displayedComponents: [.date])
                            .accentColor(Color("PrimaryColor"))
                            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .padding(.horizontal)
                            .frame(maxHeight: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        
                        Spacer().frame(height: 20)
                        
                        TextField("", text: $CPF, prompt: Text("CPF").foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.8)))
                            .keyboardType(.numberPad)
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .padding(.horizontal)
                            .frame(maxHeight: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Spacer().frame(height: 20)
                        
                        TextField("", text: $phone, prompt: Text("Celular").foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.8)))
                            .keyboardType(.numberPad)
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .padding(.horizontal)
                            .frame(maxHeight: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Spacer().frame(height: 20)
                        
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
                        
                        Spacer().frame(height: 20)
                        
                        SecureTextField(text: $passwordConfirm, placeholder: "Confirmar Senha")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .padding(.horizontal)
                            .frame(maxHeight: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Spacer().frame(height: 52)
                        
                        Button(action: {
                            Networking.signup(name: name, birth: birth, CPF: CPF, phone: phone, email: email, password: password, passwordConfirm: passwordConfirm) { result in
                                switch result {
                                case .success(let token):
                                    responseText = token
                                case .failure(let error):
                                    responseText = "Erro: \(error.localizedDescription)"
                                }
                            }
                        }) {
                            Text("Cadastrar")
                                .font(Font.system(size: 26, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(10)
                                .frame(height: 60)
                        }
                        Spacer().frame(height: 60)
                    } .padding(30)
                        .padding(.top, 2)
                }
            }.onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
