//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 23/09/2023.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService {
    
    @Published private(set) var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    
    internal func getCoinImage(urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: {[weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
