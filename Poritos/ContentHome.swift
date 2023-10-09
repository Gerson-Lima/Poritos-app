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

struct ContentHome: View {
    
    @State private var AdCarousel = 0
    @State private var searchText = ""
    
    let images: [String] = ["1", "2", "3"]
    
    let products: [Product] = [
        Product(name: "Ração Whiskas", description: "Ração Whiskas Salmão p/ gatos adultos - 900g", price: 28.99, imageName: "whiskas (salmao)"),
        Product(name: "Ração Whsikas", description: "Ração Whiskas Carne p/ gatos castrados - 900g", price: 27.99, imageName: "whiskas (carne)"),
        Product(name: "Peitoral para passeio", description: "Paitoral p/ gatos filhotes - cores variadas", price: 24.90, imageName: "peitoral"),
        Product(name: "Coleira (M)", description: "Coleira para cães de médio porte", price: 12.90, imageName: "coleira"),
        Product(name: "Antipulgas", description: "Medicamento contra pulgas p/ cães filhotes - Nexgard", price: 39.90, imageName: "antipulgas")
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
    
    var body: some View {
        
        NavigationView {
            NavigationStack {
                ZStack{
                    Color("BGColor").ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            
                            Spacer().frame(width: 0, height: 20)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                                    .opacity(0.2)
                                    .frame(height: 36)
                                    .padding(.horizontal)
                                
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
                            
                            Spacer().frame(width: 20, height: 31)
                            
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
                                    )
                                
                                HStack {
                                    ForEach(images.indices, id: \.self) {index in
                                        Circle()
                                            .fill(self.AdCarousel == index ? Color("PrimaryColor") : Color.gray)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                            }
                            
                            Spacer().frame(width: 20, height: 40)
                            
                            HStack {
                                Text("Produtos recomendados")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                
                                Button(action: {}) {
                                    Text("Ver mais")
                                        .font(.system(size: 17))
                                        .fontWeight(.regular)
                                        .padding(.horizontal)
                                }
                            }
                            
                            if !noResultsMessage.isEmpty {
                                Text(noResultsMessage)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                                    .fontWeight(.regular)
                                    .padding()
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(rows: [GridItem(.flexible())]) {
                                        ForEach(filteredProducts) { product in
                                            CardView(product: product)
                                                .frame(width: 210, height: 280)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                }.navigationBarTitle("Início")
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationBarItems(
                        trailing: Button(action: {}) {
                            Image(systemName: "bell.badge").foregroundColor(Color("PrimaryColor"))})
            }
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
}

struct CardView: View {
    let product: Product
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
              
            VStack {
                if let imageName = product.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
//                } else {
//                    Text("Sem imagem")
//                        .foregroundColor(.black)
//                        .fontWeight(.bold)
//                        .font(.system(size: 14))
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
                
                Spacer().frame(width: 0, height: 20)
                
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

struct ContentHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentHome()
    }
}
