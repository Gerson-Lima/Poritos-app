//
//  ContentHome.swift
//  Poritos
//
//  Created by Gerson Lima on 23/09/23.
//

import SwiftUI

struct ContentHome: View {
    
    @State private var AdCarousel = 0
    @State private var searchText = ""
    
    let images : [String] = ["1", "2", "3"]
    let things: [String] = ["Ração Whiskas", "Ração Pedigree", "Coleira (G)", "Coleira (M)", "Antipulgas"]
    
    var filteredThings: [String] {
        if searchText.isEmpty {
            return things
        } else {
            return things.filter { thing in
                thing.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            NavigationStack {
                ZStack{
                    Color("BGColor").ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
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
                            
                            Spacer().frame(width: 20, height: 20)
                            
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
                            
                            Spacer().frame(width: 20, height: 60)
                            
                            HStack {
                                Text("Produtos recomendados")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                    .fixedSize(horizontal: true, vertical: false)
                                Button(action: {}) {
                                    Text("Ver mais")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal)
                                        .foregroundColor(Color("PrimaryColor"))
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem(.flexible())]) {
                                    ForEach(filteredThings, id: \.self) { thing in
                                        CardView(text: thing)
                                            .frame(width: 150, height: 200)
                                        
                                    }
                                }
                                .padding()
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
    let text: String
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
              
            VStack {
                Image("dog")
                    .resizable()
                    .scaledToFit()
                        Text(text)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
            }
        }
    }
}


struct ContentHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentHome()
    }
}
