//
//  ImageService.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import UIKit
import Foundation


struct ImageService {
    
    
    enum ImageError: Error {
        case invalidURL
    }
    
    func getImage(from stringURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: stringURL) else {
            completion(nil, ImageError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}





let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCacheWithURLString(for URLString: String, at placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
