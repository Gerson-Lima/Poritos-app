//
//  passwordView.swift
//  Poritos
//
//  Created by Gerson Lima on 21/09/23.
//

import SwiftUI

struct SecureTextField: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if isSecureField {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.8))
                }
            }
            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 1))
                .onTapGesture {
                    
                    if !text.isEmpty {
                        isSecureField.toggle()
                    }
                }
                .disabled(text.isEmpty)
        }
    }
}
struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
