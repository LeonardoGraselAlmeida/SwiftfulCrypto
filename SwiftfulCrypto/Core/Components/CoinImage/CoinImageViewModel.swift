//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 23/09/2023.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    internal init(coin: CoinModel, coinImageService: CoinImageService? = nil) {
        self.coin = coin
        self.coinImageService = coinImageService ?? CoinImageService(coin: coin)
        addSubscribers()
        getImage()
    }
    
    private func addSubscribers() {
        coinImageService.$image
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
    private func getImage() {
        coinImageService.getCoinImage()
    }
}
