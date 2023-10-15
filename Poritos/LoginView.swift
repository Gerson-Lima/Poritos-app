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
    @State public var token: String? = nil
    @State private var errorMessage: String? = nil
    @State private var redirectToHome = false
    @State private var showAlert: Bool = false
    
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
                            
                            Button(action: {logar(email: email, password: password)}) {
                                Text("Entrar")
                            }
                            .foregroundColor(Color(.white))
                            .font(Font.system(size: 26, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(10)
                            
                            Spacer().frame(height: 16)
                            
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Credenciais inválidas."),
                                        message: Text("Email ou senha incorretos"),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
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
                            
                            .padding(.bottom, 30)
                            .navigationDestination(
                                isPresented: $redirectToHome) {
                                    ContentHome()
                                }
                    }
                    
                }.onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
    func logar(email: String, password: String) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/login/") else {
            print("URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            print("Erro ao serializar JSON")
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na requisição: (error?.localizedDescription ?? Erro desconhecido)")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                
//                let jsonString = "\(json)"
            }
                
            do {
                let resposta = try JSONDecoder().decode(Resposta.self, from: data)
                
                if let token = resposta.token {
                    self.token = token
                    tokenManager.token = token
                    print("\(tokenManager.token)")
                    redirectToHome = true
                    
                } else if let erro = resposta.erro {
                    self.errorMessage = erro
                    
                }
                else{
                    showAlert = true
                }
            } catch {
                print("Erro ao decodificar resposta: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}

struct Resposta: Codable {
    let token: String?
    let erro: String?
}


