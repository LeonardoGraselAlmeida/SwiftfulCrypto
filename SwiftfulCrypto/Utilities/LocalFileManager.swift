//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Leonardo Almeida on 23/09/2023.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private let fileManager: FileManager
    
    private init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    internal func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. Save Image: \(imageName) \(error)")
        }
    }
    
    internal func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              fileManager.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        
        if !fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. Foldername: \(folderName) - \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderName = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderName.appendingPathComponent(imageName + ".png")
    }
}
