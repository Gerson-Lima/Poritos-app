//
//  test.swift
//  Poritos
//
//  Created by Gerson Lima on 23/09/23.
//

import SwiftUI

struct ContentHome: View {
    
    @State private var AdCarousel = 0
    
    let images : [String] = ["1", "2", "3"]
    
    var body: some View {
        
        NavigationView {
            NavigationStack {
                ZStack{
                    Color("BGColor").ignoresSafeArea()
                    ScrollView {
                        
                        VStack {
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
                                        } else if value.translation.width > 0 {
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
                    }
                }.navigationBarTitle("Início")
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationBarItems(
                        trailing: Button(action: {}) {
                            Image(systemName: "bell.badge").foregroundColor(Color("PrimaryColor"))})
            }
        }
        .onAppear {
            print("Appear")
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true){ timer in
                if self.AdCarousel + 1 == self.images.count {
                    self.AdCarousel = 0
                } else {
                    self.AdCarousel += 1
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
