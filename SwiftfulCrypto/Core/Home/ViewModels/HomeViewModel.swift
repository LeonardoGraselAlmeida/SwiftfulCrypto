//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 23/09/2023.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let mainQueue: DispatchQueue
    private let coinService: CoinDataService
    
    private var cancellables = Set<AnyCancellable>()
    
    internal init(mainQueue: DispatchQueue = DispatchQueue.main, coinService: CoinDataService = CoinDataService()) {
        self.mainQueue = mainQueue
        self.coinService = coinService
        addSubscribers()
        getCoins()
    }
    
    private func addSubscribers() {
        coinService.$allCoins.sink { [weak self] returnedCoins in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellables)
    }
    
    private func getCoins() {
        coinService.getCoins()
    }
    
    
}
