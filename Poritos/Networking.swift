//
//  Networking.swift
//  Poritos
//
//  Created by Gerson Lima on 20/09/23.
//

import Foundation

class Networking {
    
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
}
