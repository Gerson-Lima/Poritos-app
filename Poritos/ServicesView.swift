//
//  ServicesView.swift
//  Poritos
//
//  Created by Gerson Lima on 17/10/23.
//

import SwiftUI

struct ServicesView: View {
    let pet: Pet
    
    @Environment(\.presentationMode) var presentation
    
    @State var ServicesScreen = false
    
    var body: some View {
        NavigationView {
            NavigationStack {
                ZStack{
                    Color("BGColor")
                        .edgesIgnoringSafeArea(.all)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            Rectangle().frame(width: 40, height: 5)
                                .foregroundColor(.gray)
                                .cornerRadius(3.0)
                                .padding(.bottom)
                                .opacity(0.5)
                                .padding(.top, 12)
                            
                            Button(action:{
                                presentation.wrappedValue.dismiss()
                            }, label: {
                                Label("Back", systemImage: "chevron.left")
                            }).padding(.trailing, 285)
                                .padding(.bottom, 8)
                            Text("Escolha os serviços para:")
                                .font(.system(size: 18))
                                .foregroundColor(Color(.gray).opacity(0.7))
                                .padding(.trailing, 170)
                            
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 21)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                                    .frame(width: 382, height: 158)
                                
                                HStack {
                                    Image(pet.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 158, height: 158)
                                        .clipped()
                                        .cornerRadius(21)
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(pet.name)
                                                .font(.system(size: 22))
                                                .foregroundColor(.black)
                                                .fontWeight(.semibold)
                                                .font(.system(size: 17))
                                                .padding(.leading, 6)
                                            
                                            Spacer()
                                            
                                            if pet.sex == .macho {
                                                Image("genderMale")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding(.trailing, 8)
                                            } else {
                                                Image("genderFemale")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding(.trailing, 8)
                                            }
                                        }
                                        
                                        Spacer().frame(height: 12)
                                        
                                        HStack {
                                            Text("Espécie\n")
                                                .foregroundColor(.gray)
                                            + Text("\(pet.species)")
                                                .foregroundColor(.black)
                                            
                                            Spacer().frame(width: 40)
                                            
                                            Text("Idade\n")
                                                .foregroundColor(.gray)
                                            + Text("\(pet.age)")
                                                .foregroundColor(.black)
                                            
                                        }.font(.system(size: 16))
                                            .padding(.leading, 8)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer().frame(height: 10)
                                        
                                        HStack {
                                            Text("Peso\n")
                                                .foregroundColor(.gray)
                                            + Text(String(format: "\(pet.mass) kg"))
                                                .foregroundColor(.black)
                                            
                                            Spacer().frame(width: 44)
                                            
                                            Text("Raça\n")
                                                .foregroundColor(.gray)
                                            + Text("\(pet.race)")
                                                .foregroundColor(.black)
                                            
                                        }.font(.system(size: 16))
                                            .padding(.leading, 8)
                                            .multilineTextAlignment(.leading)
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                            .frame(width: 382, height: 158)
                            
                        }
                    }
                }
            }
        }
    }
}


struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView(pet: ContentHome().pets[0])
    }
}
