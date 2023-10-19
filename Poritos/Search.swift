import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @State private var noResultsMessage: String = ""
    var body: some View {
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
                .padding(.top, 12)
                .padding(.bottom, 16)
                
                if !noResultsMessage.isEmpty {
                    Text(noResultsMessage)
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .padding()
                }
            }
        }
    }
}
