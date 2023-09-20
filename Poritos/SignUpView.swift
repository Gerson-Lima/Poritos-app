//
//  LoginView.swift
//  Poritos
//
//  Created by Gerson Lima on 19/09/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var responseText = ""
    
    var body: some View {
        ZStack{
            Color("PrimaryColor").ignoresSafeArea()
            VStack{
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                
                Spacer().frame(height: 16)
                
                Button(action: {sendRequest(username: username, password: password)}) {
                    Text("Login")
                }
            }.padding(30)
        }
    }
    
    func sendRequest(username: String, password: String) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/login/") else {
            responseText = "URL inválida"
            return
        }
       
        let body: [String: String] = ["username": username, "password": password]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    responseText = "Erro: \(error.localizedDescription)"
                    return
                }
                
                struct TokenResponse: Codable {
                    let token: String
                }
                
                if let data = data {
                    do {
                        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                        let token = tokenResponse.token
                        responseText = "\(token)"
                        print(responseText)
                    } catch {
                        responseText = "Erro ao decodificar o JSON: \(error.localizedDescription)"
                    }
                }
            }.resume()
            
        } catch {
            responseText = "Erro na serialização do JSON: \(error.localizedDescription)"
        }
    }
}

struct SignUpView: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
