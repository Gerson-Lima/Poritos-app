//
//  ContentHome.swift
//  Poritos
//
//  Created by Gerson Lima on 23/09/23.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let imageName: String?
}

struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let species: String
    let race: String
    let age: String
    let mass: String
    let sex: Sex
    enum Sex {
        case macho
        case femea
    }
    let imageName: String

}

struct ContentHome: View {
    
    @State private var AdCarousel = 0
    @State private var searchText = ""
    @State private var addPet = false
    
    let images: [String] = ["1", "2", "3"]
    
    let products: [Product] = [
        Product(name: "Ração Whiskas", description: "Ração Whiskas Salmão p/ gatos adultos - 900g", price: 28.99, imageName: "whiskas (salmao)"),
        Product(name: "Ração Whiskas", description: "Ração Whiskas Carne p/ gatos castrados - 900g", price: 27.99, imageName: "whiskas (carne)"),
        Product(name: "Peitoral para passeio", description: "Peitoral p/ gatos filhotes - cores variadas", price: 24.90, imageName: "peitoral"),
        Product(name: "Coleira (M)", description: "Coleira para cães de médio porte", price: 12.90, imageName: "coleira"),
        Product(name: "Antipulgas", description: "Medicamento contra pulgas p/ cães filhotes - Nexgard", price: 39.90, imageName: "antipulgas"),
        Product(name: "Brinquedo interativo", description: "Brinquedo recheável - Osso p/ cães (pet & Kauf)", price: 39.90, imageName: "osso")
    ]
    
    let pets: [Pet] = [
        Pet(name: "Tom", species: "Gato", race: "Siamês", age: "7 anos", mass: "15.6", sex: .macho, imageName: "pet1"),
        Pet(name: "Saori", species: "Gato", race: "Munchkin", age: "2 anos", mass: "12.2", sex: .femea, imageName: "pet2")
       
    ]
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { product in
                product.name.localizedCaseInsensitiveContains(searchText) || product.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var noResultsMessage: String {
        if !searchText.isEmpty && filteredProducts.isEmpty {
            return "Nenhum produto encontrado..."
        }
        return ""
    }
    
    var topProducts: [Product] {
        return filteredProducts
    }
    
    var body: some View {
        
        TabView {
            NavigationView {
                NavigationStack {
                    ZStack{
                        Color("BGColor")
                            .edgesIgnoringSafeArea(.all)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                
                                Spacer().frame(width: 0, height: 22)
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray)
                                        .opacity(0.2)
                                        .frame(height: 36)
                                        .padding(.horizontal, 16)
                                    
                                    HStack {
                                        TextField("", text: $searchText, prompt: Text("Buscar").foregroundColor(.gray))
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 30)
                                            .textContentType(.name)
                                        
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 28)
                                    }
                                }
                                
                                Spacer().frame(width: 20, height: 24)
                                
                                if searchText.isEmpty {
                                    Image(images[AdCarousel])
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(21)
                                        .padding(.horizontal, 16)
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                                        .gesture(DragGesture()
                                            .onEnded { value in
                                                if value.translation.width < 0 {
                                                    withAnimation {
                                                        self.AdCarousel = (self.AdCarousel + 1) % self.images.count
                                                    }
                                                } else {
                                                    withAnimation {
                                                        self.AdCarousel = (self.AdCarousel - 1 + self.images.count) % self.images.count
                                                    }
                                                }
                                            }
                                        ).shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
                                    
                                    HStack {
                                        ForEach(images.indices, id: \.self) {index in
                                            Circle()
                                                .fill(self.AdCarousel == index ? Color("PrimaryColor") : Color.gray)
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                }
                                
                                Spacer().frame(height: 40)
                                
                                HStack {
                                    Text("Conheça nossos produtos")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 16)
                                    
                                    Button(action: {}) {
                                        Text("Ver mais")
                                            .font(.system(size: 17))
                                            .fontWeight(.regular)
                                            .padding(.horizontal)
                                    }
                                }
                                
                                Spacer().frame(height: 16)
                                
                                if !noResultsMessage.isEmpty {
                                    Text(noResultsMessage)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                        .fontWeight(.regular)
                                        .padding()
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack {
                                            ForEach(topProducts) { product in
                                                CardView(product: product)
                                                    .frame(width: 210, height: 260, alignment: .leading)
                                                    .padding(.leading, 16)
                                                    .padding(.bottom, 16)
                                                    .padding(.top, 10)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Spacer().frame(height: 30)
                            
                            Text("Meus pets")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                            
                            Spacer().frame(height: 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(pets) { pet in
                                        PetView(pet: pet)
                                            .padding(.leading, 16)
                                            .padding(.bottom, 16)
                                            .padding(.top, 10)
                                        
                                    }
                                    
                                    
                                    VStack {
                                        NavigationLink(destination: AddPetView()) {
                                            Button(action: {addPet = true}) {
                                            }
                                            Image(systemName: "plus")
                                                .resizable()
                                                .frame(width: 22, height: 22, alignment: .center)
                                                .foregroundColor(Color("PrimaryColor"))
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: 4)
                                                        .frame(width: 98, height: 98))
                                                .shadow(color: .black.opacity(0.1), radius: 10, x: 8, y: 8)
                                            
                                        }
                                        Text("Novo pet")
                                            .fontWeight(.medium)
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("PrimaryColor"))
                                    }.padding(.horizontal)
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 0)
                        .navigationBarTitle("Início")
                        .navigationBarItems(
                            trailing: Button(action: {}) {
                                Image(systemName: "bell.badge").foregroundColor(Color("PrimaryColor"))})
                        .edgesIgnoringSafeArea(.bottom)
                        .background(ignoresSafeAreaEdges: .all)
                    
                }
                
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
                
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 4, repeats: true){ timer in
                        if self.AdCarousel + 1 == self.images.count {
                            self.AdCarousel = 0
                        } else {
                            self.AdCarousel += 1
                        }
                        
                    }
                }
            }
            
            
            .tabItem {
                Image(systemName: "house.fill")
                Text("Início")
            }
            NavigationView {
                NavigationStack {
                    ZStack {
                        Color("BGColor")
                            .ignoresSafeArea()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack {
                                Image("BannerServices")
                                    .resizable()
                                    .frame(width: 382, height: 344)
                                    .padding(.top, 22)
                                
                                Spacer().frame(height: 44)
                                
                                HStack {
                                    Text("Selecione um pet para ser atendido")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 16)
                                    
                                    Button(action: {}) {
                                        Text("Editar")
                                            .font(.system(size: 17))
                                            .fontWeight(.regular)
                                            .padding(.trailing, 16)
                                    }
                                }
                            }
                            
                            LazyVStack {
                                ForEach(pets) { pet in
                                    PetServiceView(pet: pet)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 16)
                                }
                            }
                          
                                NavigationLink(destination: AddPetView()){
                                    Button(action: {addPet = true}) {
                                    }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: .infinity, height: 158)
                                        .cornerRadius(21)
                                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                                    
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 32, height: 32, alignment: .center)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                } .padding(.horizontal, 16)
                            }
                            
                            Spacer().frame(height: 22)
                            
                        }
                    }
                    
                    Spacer().frame(height: 0)
                        .navigationBarTitle("Serviços")
                        .edgesIgnoringSafeArea(.bottom)
                        .background(ignoresSafeAreaEdges: .all)
                }
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("Serviços")
            }
            
            
            
            NavigationView {
                NavigationStack {
                    ZStack {
                        Color("BGColor")
                            .ignoresSafeArea()
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Text("Carrinho") //CONTEUDO DO CARRINHO AQUI
                            }
                        }
                        
                    }
                    Spacer().frame(height: 0)
                        .navigationBarTitle("Carrinho")
                        .edgesIgnoringSafeArea(.bottom)
                        .background(ignoresSafeAreaEdges: .all)
                }
            }
            
            .tabItem {
                Image(systemName: "cart.fill")
                Text("Carrinho")
            }
            NavigationView {
                NavigationStack {
                    ZStack {
                        Color("BGColor")
                            .ignoresSafeArea()
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Text("Perfil") //CONTEUDO DO PERFIL AQUI
                            }
                        }
                        
                    }
                    Spacer().frame(height: 0)
                        .navigationBarTitle("Perfil")
                        .edgesIgnoringSafeArea(.bottom)
                        .background(ignoresSafeAreaEdges: .all)
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Perfil")
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .accentColor(Color("PrimaryColor"))
    }
    
    struct CardView: View {
        let product: Product
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                
                VStack {
                    Spacer().frame(width: 0, height: 10)
                    if let imageName = product.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    
                    Text(product.name)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 17))
                        .padding(.top, 5)
                        .frame(maxWidth: 190, alignment: .leading)
                    
                    Spacer().frame(width: 0, height: 10)
                    
                    Text(product.description)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.top, 1)
                        .padding(.horizontal, 2)
                        .frame(maxWidth: 190, alignment: .leading)
                    
                    Spacer().frame(width: 0, height: 10)
                    
                    HStack {
                        Text(String(format: "R$ %.2f", product.price))
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        Spacer().frame(width: 40, height: 0)
                        
                        Button(action: {}) {
                            Image(systemName: "cart.circle.fill")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.system(size: 45))
                        }
                    }
                }
            }
        }
    }
}

struct PetView: View {
    let pet: Pet
    
    var body: some View {
        
        ZStack{
            VStack {
                Spacer().frame(width: 0, height: 10)
                
                Image(pet.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                            .frame(width: 92, height: 92)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 100, height: 100)
                        
                    ).shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                
                Text(pet.name)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .padding(.top, 1)
                    .frame(maxWidth: 190, alignment: .center)
                
                Spacer().frame(width: 0, height: 10)
                
            }
        }
    }
}

struct PetServiceView: View {
    let pet: Pet
    
    @State var ServicesScreen = false
    
    var body: some View {
        Button(action: {ServicesScreen = true}) {
            ZStack {
                RoundedRectangle(cornerRadius: 21)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                    .frame(width: 382, height: 158)
                    .sheet(isPresented: $ServicesScreen) {
                        ServicesView(pet: ContentHome().pets[0])
                    }
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
//                Image(systemName: "chevron.right")
//                    .padding(.leading, 320)
//                    .padding(.top, 100)
//                SETA LATERAL (DESNECESÁRIA?)
            }
        }
    }
}

struct ContentHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentHome()
    }
}

