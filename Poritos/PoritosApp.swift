//
//  PoritosApp.swift
//  Poritos
//
//  Created by Gerson Lima on 18/09/23.
//

import SwiftUI

@main
struct PoritosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tokenManager)
                .preferredColorScheme(.light)
        }
    }
}

class TokenManager: ObservableObject {
    @Published var token: String = "53b76de6ca1e508efb191525ab64d4ac3fdbf93c"
    @Published var petsArray: [[String: Any]] = []
}
let tokenManager = TokenManager()

class GlobalData: ObservableObject {
    @Published var globalNomesArray: [[String: Any]] = []
}
