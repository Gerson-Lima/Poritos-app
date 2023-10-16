//
//  AddPet.swift
//  Poritos
//
//  Created by Gerson Lima on 15/10/23.
//

import SwiftUI

struct AddPetView: View {
    
    
    @Environment(\.presentationMode) var presentationMode

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
        
        NavigationView {
            NavigationStack {
                ZStack{
                    Color("BGColor")
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            
                            Spacer().frame(width: 0, height: 40)
                            
                            if image != nil {
                                image?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 158, height: 158)
                                    .cornerRadius(21)
                                    .clipShape(Rectangle())
                                
                            } else {
                                Rectangle()
                                    .fill(Color("PrimaryColor"))
                                    .frame(width: 158, height: 158)
                                    .cornerRadius(21)
                                    .onTapGesture {
                                        isImagePickerPresented.toggle()
                                    }
                            }
                            
                            Button("Salvar/Alterar Foto") {
                                isImagePickerPresented.toggle()
                            }
                            .padding(8)
                            
                            TextField("Nome", text: $petName)
                                .foregroundColor(Color.black)
                                .autocapitalization(.none)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            TextField("Espécie", text: $petSpecies)
                                .foregroundColor(Color.black)
                                .autocapitalization(.none)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            TextField("Raça", text: $petRace)
                                .foregroundColor(Color.black)
                                .autocapitalization(.none)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            TextField("Idade", text: $petAge)
                                .foregroundColor(Color.black)
                                .autocapitalization(.none)
                                .font(Font.system(size: 16, weight: .regular))
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                                .padding(.horizontal)
                                .frame(maxHeight: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                            ZStack {
                                
                                
                                HStack {
                                    TextField("Peso (kg)", text: $petMass)
                                        .foregroundColor(Color.black)
                                        .autocapitalization(.none)
                                        .font(Font.system(size: 16, weight: .regular))
                                        .padding(.bottom, 16)
                                        .padding(.top, 16)
                                        .padding(.horizontal)
                                        .frame(width: 110, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    ZStack {
                                        HStack {
                                            Spacer().frame(width: 14)
                                            Text("Sexo:")
                                                .foregroundColor(Color.gray)
                                                .opacity(0.55)
                                                .autocapitalization(.none)
                                                .font(Font.system(size: 16, weight: .regular))
                                                .frame(width: 46)
                                            
                                            HStack {
                                                Button(action: {selectedSex = .macho}) {
                                                    Text("Macho")
                                                        .foregroundColor(selectedSex == .macho ? .white : .primary)
                                                        .font(Font.system(size: 14, weight: .semibold))
                                                        .foregroundColor(.white)
                                                        .frame(maxWidth: 82)
                                                        .cornerRadius(10)
                                                        .frame(height: 46)
                                                        .background(selectedSex == .macho ? Color("PrimaryColor") : Color.white)
                                                        .cornerRadius(10)
                                                       
                                                }
                                                .shadow(radius: selectedSex == .macho ? 2 : -2)
                                                .background(Color.white)
                                                
                                                Button(action: {selectedSex = .femea}) {
                                                    Text("Fêmea")
                                                        .foregroundColor(selectedSex == .femea ? .white : .primary)
                                                        .font(Font.system(size: 14, weight: .semibold))
                                                        .foregroundColor(.white)
                                                        .frame(maxWidth: 82)
                                                        .cornerRadius(10)
                                                        .frame(height: 46)
                                                        .background(selectedSex == .femea ? Color.init(red: 255/255, green: 69/255, blue: 257/255) : Color.white)
                                                        .cornerRadius(10)
                                                }
                                                .shadow(radius: selectedSex == .femea ? 2 : -2)
                                                .background(Color.white)
                                                
                                                
                                            }
                                            .padding(.trailing)
                                        }
                                        .padding(.bottom, 16)
                                        .padding(.top, 16)
                                        .padding(.leading, 2)
                                        .frame(width: 240, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            
                            Spacer().frame(width: 0, height: 40)
                            
                            Button(action: {
                                Networking.enviarRequisicao(nome: petName, especie: petSpecies, raca: petRace, idade: petAge, sexo: selectedSex, peso: petMass, image: image, showAlert: $showAlert)
                                
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
                                    dismissButton: .default(Text("OK")) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                            }
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(image: $image)
                        }
                        
                    }
                    .padding(.horizontal, 30)
                }
                .navigationTitle("Cadastrar pet")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView()
    }
}
