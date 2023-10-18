//
//  Networking.swift
//  Poritos
//
//  Created by Gerson Lima on 20/09/23.
//

import Foundation
import SwiftUI

class Networking {
    @State private var showAlert: Bool = false
    
    static func signup(name: String, birth: Date, CPF: String, phone: String, email: String, password: String, passwordConfirm: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/login/") else {
            completion(.failure(NSError(domain: "URL inválida", code: 0, userInfo: nil)))
            return
        }
        
        let body: [String: String] = ["name": name, "birth": birth.description]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                struct TokenResponse: Codable {
                    let token: String
                }
                
                if let data = data {
                    do {
                        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                        let token = tokenResponse.token
                        completion(.success(token))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
    static func enviarRequisicao(nome: String, especie: String, raca: String, idade: String, sexo: Pet.Sex, peso: String, image: Image?, showAlert: Binding<Bool>) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/animais/") else { return }
        
        var sex: String
        if (sexo == .macho) {
            sex = "macho"
        } else {
            sex = "femea"
        }
        
        let json: [String: Any] = [
            "nome": nome,
            "especie": especie,
            "raca": raca,
            "idade": idade,
            "sexo": sex,
            "peso": peso
        ]
        print(json)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue("Token \(tokenManager.token)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    showAlert.wrappedValue = true
                } else {
                    print("Erro no servidor. Código de status:", response.statusCode)
                }
            }
        }
        task.resume()
    }
}


