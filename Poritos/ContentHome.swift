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
    let age: Int
    let mass: Float
    let sex: Sex
    enum Sex {
        case macho
        case femea
    }
    let imageName: String
    
}
var globalPets: [[String: Any]] = []

struct ContentHome: View {
    
    @ObservedObject var globalData = GlobalData()
    @State private var AdCarousel = 0
    @State private var searchText = ""
    @State private var addPet = false
    
    let images: [String] = ["1", "2", "3"]
    
    @State public var products: [Product] = []
    
    @State public var pets: [Pet] = []
    
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
                                
                                    .onAppear(){
                                        getFuncAnimal(contentHome: self)
                                        getProducts(contentHome: self)
                                    }
                                    
                                
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
                                
                                Spacer().frame(height: 30)
                                
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
                                            ForEach(topProducts.prefix(6)) { product in
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
                            
                            Spacer().frame(height: 8)
                            
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
                                        .padding(.bottom)
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
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true){ timer in
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
                                    PetServiceView(pet: pet, pets: $pets)
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
                                .padding(.top, 22)
                                .padding(.bottom, 16)
                                
                                if !noResultsMessage.isEmpty {
                                    Text(noResultsMessage)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                        .fontWeight(.regular)
                                        .padding()
                                } else {
                                    ScrollView(.vertical, showsIndicators: true) { // Mudei para ScrollView vertical
                                        LazyVGrid(columns: [
                                            GridItem(.flexible(), spacing: -16),
                                            GridItem(.flexible(), spacing: -16)
                                        ]) {
                                            ForEach(topProducts) { product in
                                                CardViewLoja(product: product)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)) // Espaçamento das bordas
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 0)
                        .navigationBarTitle("Loja")
                        .edgesIgnoringSafeArea(.bottom)
                        .background(ignoresSafeAreaEdges: .all)
                }
            }
            
            .tabItem {
                Image(systemName: "cart.fill")
                Text("Loja")
                
                
                
                
                
                
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
                    if let imageUrlString = product.imageName,
                       let imageUrl = URL(string: imageUrlString) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            // Placeholder enquanto a imagem está sendo carregada
                            ProgressView()
                        }
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

struct CardViewLoja: View {
    let product: Product
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                .frame(height: 255)
            
            VStack {
                Spacer().frame(width: 0, height: 10)
                if let imageUrlString = product.imageName,
                   let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        // Placeholder enquanto a imagem está sendo carregada
                        ProgressView()
                    }
                }
                
                Text(product.name)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                    .padding(.top, 5)
                    .frame(maxWidth: 160, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer().frame(width: 0, height: 10)
                
                Text(product.description)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.top, 1)
                    .padding(.horizontal, 2)
                    .frame(maxWidth: 160, alignment: .leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Spacer().frame(width: 0, height: 10)
                
                HStack {
                    Text(String(format: "R$ %.2f", product.price))
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                        .padding(.leading, 3)
                    
                    Spacer().frame(width: 40, height: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "cart.circle.fill")
                            .foregroundColor(Color("PrimaryColor"))
                            .font(.system(size: 45))
                            .frame(width: 40, height: 40)
                    }
                    .padding(.top, 4)
                    .alignmentGuide(HorizontalAlignment.center) { d in
                        d[.bottom]
                    }
                }
            } .padding(.bottom, 8)
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

 func getFuncAnimal(contentHome: ContentHome) {
    
    let url = URL(string: "http://127.0.0.1:8000/api/animais/listar_animais_usuario/")!
    var request = URLRequest(url: url)
    
    request.setValue("Token \(tokenManager.token)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
    
   
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Erro: \(error?.localizedDescription ?? "Erro desconhecido")")
            return
        }
        
        var updatedPets = [Pet]()
        
        do {
            let animais = try JSONDecoder().decode([Animal].self, from: data)
            
            for animal in animais {
                
                let nome = animal.nome
                let especie = animal.especie
                let raca = animal.raca
                let peso = animal.peso
                let idade = animal.idade
                let sexo = animal.sexo
//                let foto = animal.foto
                
                var pesoFloat: Float = 0.0
                if let x = Float(peso) {
                    pesoFloat = x
                }
                
                if (sexo == "macho") {
                   let  newPet = Pet(name: nome, species: especie, race: raca, age: idade, mass: pesoFloat, sex: .macho, imageName: "pet1")
                    updatedPets.append(newPet)
                } else {
                    let newPet = Pet(name: nome, species: especie, race: raca, age: idade, mass: pesoFloat, sex: .femea, imageName: "pet2")
                    updatedPets.append(newPet)
                }
                
            }
       
        } catch {
            print("Erro ao decodificar JSON: \(error)")
        }
        contentHome.pets = updatedPets
        
//        print(contentHome.pets)
        
    }
    
    task.resume()
}

func getProducts(contentHome: ContentHome) {
    guard let url = URL(string: "http://127.0.0.1:8000/api/produtos/") else {
        fatalError("URL inválida")
    }

    // Crie a tarefa de sessão
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Verifique se houve algum erro
        if let error = error {
            print("Erro ao fazer a requisição: \(error)")
            return
        }

        // Verifique se a resposta contém dados
        guard let data = data else {
            print("Nenhum dado recebido")
            return
        }

        var updatedProducts = [Product]()

        do {
               // Tente decodificar os dados como um array de produtos
               let jsonDecoder = JSONDecoder()
               let produtos = try jsonDecoder.decode([Produto].self, from: data)
            
            for produto in produtos {
                
                var precoDouble: Double = 0.0
                if let y = Double(produto.preco) {
                    precoDouble = y
                }
                
                let newProduct = Product(name: produto.nome, description: produto.descricao, price: precoDouble, imageName: produto.imagem)
                updatedProducts.append(newProduct)
            }

        } catch {
            print("Erro ao decodificar JSON: \(error)")
        }
        contentHome.products = updatedProducts
//        print(contentHome.products)
    }

    task.resume()
}

struct Animal: Codable {
    let id: Int
    let nome: String
    let especie: String
    let raca: String
    let peso: String
    let idade: Int
    let sexo: String
    let foto: String
    let usuario: Int
}

struct Produto: Codable {
    let id: Int
    let nome: String
    let descricao: String
    let preco: String
    let desconto: String
    let estoque: Int
    let disponivel: Bool
    let data_criacao: String
    let imagem: String
}

struct PetServiceView: View {
    let pet: Pet
    
    @Binding var pets: [Pet]
    @State var ServicesScreen = false
    
    var body: some View {
        
        Button(action: {ServicesScreen = true}) {
            ZStack {
                RoundedRectangle(cornerRadius: 21)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 3)
                    .frame(width: 382, height: 158)
                    .sheet(isPresented: $ServicesScreen) {
                        ServicesView(pet: pet)
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
                            
                            Spacer().frame(width: 51)
                            
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

