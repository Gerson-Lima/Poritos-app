//
//  AddPet.swift
//  Poritos
//
//  Created by Gerson Lima on 15/10/23.
//

import SwiftUI
import Combine
import Foundation

struct AddPetView: View {
    
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @State private var petName: String = ""
    @State private var petSpecies: String = ""
    @State private var petRace: String = ""
    @State private var petAge: String = ""
    @State private var petMass: String = ""
    @State private var selectedSex: Pet.Sex = .macho
    @State private var showAlert: Bool = false
    
    func enviarRequisicao(nome: String, especie: String, raca: String, idade: String, sexo: Pet.Sex, peso: String) {
        // URL do endpoint
        guard let url = URL(string: "http://127.0.0.1:8000/api/animais/") else { return }
        
        var sex: String
        if (sexo == .macho) {
            sex = "macho"
        } else {
            sex = "femea"
        }
        // Criando o JSON
        let json: [String: Any] = [
            "nome": nome,
            "especie": especie,
            "raca": raca,
            "idade": idade,
            "sexo": sex,
            "peso": peso
        ]
        print(json)
        
        // Convertendo o JSON para Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
            return
        }
        
        // Criando a requisição
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Adicionando o token como header
        request.setValue("Token \(tokenManager.token)", forHTTPHeaderField: "Authorization")
        
        // Adicionando o JSON como corpo da requisição
        request.httpBody = jsonData
        
        // Criando a tarefa de sessão
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    showAlert = true
                } else {
                    print("Erro no servidor. Código de status:", response.statusCode)
                }
            }
            
        }
        
        task.resume()
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                if image != nil {
                    image?
                        .resizable()
                        .cornerRadius(21)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                        .clipShape(Rectangle())
                } else {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 200, height: 200)
                        .cornerRadius(21)
                        .onTapGesture {
                            isImagePickerPresented.toggle()
                        }
                }
                
                Button("Salvar/Alterar Foto") {
                    isImagePickerPresented.toggle()
                }
                .padding()
                
                TextField("Nome", text: $petName)
                TextField("Espécie", text: $petSpecies)
                TextField("Raça", text: $petRace)
                TextField("Idade", text: $petAge)
                TextField("Peso", text: $petMass)
                
                // Seletor de Sexo
                Picker("Sexo", selection: $selectedSex) {
                    Text("Macho").tag(Pet.Sex.macho)
                    Text("Fêmea").tag(Pet.Sex.femea)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button("Enviar Requisição") {
                    enviarRequisicao(nome: petName, especie: petSpecies, raca: petRace, idade: petAge, sexo: selectedSex, peso: petMass)
                } .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Goza, Bolsonaro"),
                        message: Text("Animal adicionado!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $image)
            }
            
        }
    }
}
struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView()
    }
}
