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
    @Published var token: String = "df3b7e7a0394b5b6028a6a54a655dc24f82dce9d"
    @Published var petsArray: [[String: Any]] = []
}
let tokenManager = TokenManager()

class GlobalData: ObservableObject {
    @Published var globalNomesArray: [[String: Any]] = []
}
