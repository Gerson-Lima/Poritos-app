//
//  AddPet.swift
//  Poritos
//
//  Created by Gerson Lima on 15/10/23.
//

import SwiftUI

struct AddPetView: View {
    
    @State private var image: Image?
    @State private var isImagePickerPresented = false
    @State private var petName: String = ""
    @State private var petSpecies: String = ""
    @State private var petRace: String = ""
    @State private var petAge: String = ""
    @State private var petMass: String = ""
    @State private var selectedSex: Pet.Sex = .macho
    @State private var showAlert = false
    
    var body: some View {
        TabView {
            NavigationView {
                NavigationStack {
                    ZStack{
                        Color("BGColor")
                            .edgesIgnoringSafeArea(.all)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Spacer().frame(width: 0, height: 80)
                                if image != nil {
                                    image?
                                        .resizable()
                                        .cornerRadius(21)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 158, height: 158)
                                    
                                        .clipShape(Rectangle())
                                } else {
                                    Rectangle()
                                        .fill(Color.blue)
                                        .frame(width: 158, height: 158)
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
                                Picker("Sexo", selection: $selectedSex) {
                                    Text("Macho").tag(Pet.Sex.macho)
                                    Text("Fêmea").tag(Pet.Sex.femea)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                
                                Button(action: {
                                    Networking.enviarRequisicao(nome: petName, especie: petSpecies, raca: petRace, idade: petAge, sexo: selectedSex, peso: petMass, showAlert: $showAlert)
                                    
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
                                .alert(isPresented: $showAlert) {
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
                            
                        }.padding(30)
                    }
                }
            }
        }
    }
}
struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView()
    }
}
