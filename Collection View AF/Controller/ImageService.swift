//
//  ImageService.swift
//
//  Created by Fahim Rahman on 28/12/19.
//  Copyright © 2019 Fahim Rahman. All rights reserved.
//

import UIKit

class ImageService {
    
    static let cache = NSCache< NSString, UIImage >()
    
    static func downloadImage(url: URL, completion: @escaping(_ image: UIImage?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, responseUrl, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }.resume()
    }
    
    static func getImage(url: URL, completion: @escaping(_ image: UIImage?) -> ()) {
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            
            completion(image)
        }
        else {
            downloadImage(url: url, completion: completion)
        }
    }
}
