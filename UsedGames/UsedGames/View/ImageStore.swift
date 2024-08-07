//
//  ImageStore.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 7.08.2024.
//

import UIKit

class ImageStore: ObservableObject {
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let data = image.jpegData(compressionQuality: 0.8)
        do {
             try data?.write(to: gameImageURL(foKey: key))
        } catch {
            print(error)
        }
        
        objectWillChange.send()
    }
    
    func image(forKey key: String) -> UIImage? {
        if let cachedObject = cache.object(forKey: key as NSString) {
            return cachedObject
        }
        do {
            let imageData = try Data(contentsOf: gameImageURL(foKey: key))
            let image = UIImage(data:  imageData)
            return image
        } catch {
            print("error retrieving image: \(error.localizedDescription)")
        }
        return nil
    }
    
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        try? FileManager.default.removeItem(at: gameImageURL(foKey: key))
        objectWillChange.send()
    }
    
    func gameImageURL(foKey key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
}
