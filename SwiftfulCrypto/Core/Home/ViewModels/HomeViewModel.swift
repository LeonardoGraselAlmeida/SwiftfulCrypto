//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 23/09/2023.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let mainQueue: DispatchQueueProtocol
    
    internal init(mainQueue: DispatchQueueProtocol = DispatchQueue.main) {
        self.mainQueue = mainQueue
        
        mainQueue.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.intance.coin)
            self.portfolioCoins.append(DeveloperPreview.intance.coin)
        }
    }
    
    
}
