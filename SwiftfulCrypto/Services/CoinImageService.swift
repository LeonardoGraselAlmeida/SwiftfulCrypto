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
    
    private let coin: CoinModel
    private let localFileManager: LocalFileManager
    private let folderName: String = "coin_images"
    
    init(coin: CoinModel, localFileManager: LocalFileManager = LocalFileManager.instance) {
        self.coin = coin
        self.localFileManager = localFileManager
    }
    
    internal func getCoinImage() {
        if let savedImage = localFileManager.getImage(imageName: coin.id, folderName: folderName) {
            print("Retrieved image from File Manager!")
            image = savedImage
        } else {
            print("Downloading image now")
            downloadingCoinImage()
        }
    }
    
    private func downloadingCoinImage() {
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: {[weak self] returnedImage in
                guard let self,
                      let returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.localFileManager.saveImage(image: returnedImage, imageName: self.coin.id, folderName: self.folderName)
            })
    }
    
}
