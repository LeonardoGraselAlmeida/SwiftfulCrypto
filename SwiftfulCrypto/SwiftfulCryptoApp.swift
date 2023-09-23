//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 22/09/2023.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
