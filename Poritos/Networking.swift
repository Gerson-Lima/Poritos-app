//
//  Networking.swift
//  Poritos
//
//  Created by Gerson Lima on 20/09/23.
//
import Combine
import Foundation
import SwiftUI

class Networking {
    static func signup(name: String, birth: String, CPF: String, phone: String, email: String, password: String, passwordConfirm: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/register/") else {
            completion(.failure(NSError(domain: "Networking", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = [
            "tipo_usuario": "cliente",
            "nome": name,
            "email": email,
            "password": password,
            "data_nascimento": birth,
            "cpf": CPF,
            "celular": phone
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Networking", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro na requisição: Erro ao conectar ao servidor"])))
                return
            }

            do {
                if let resposta = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let errorMessage = resposta["erro"] as? String {
                        completion(.failure(NSError(domain: "Networking", code: 2, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    } else {
                        completion(.success("Registro bem-sucedido"))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
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
