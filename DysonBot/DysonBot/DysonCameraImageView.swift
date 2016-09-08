//
//  DysonCameraImageView.swift
//  imagedown
//
//  Created by Rodhan Hickey on 08/09/2016.
//  Copyright © 2016 Bockris Systems. All rights reserved.
//

import UIKit

class DysonCameraImageView: UIImageView {
    var placeholderImage: UIImage?

    func startUpdates(url: URL) {
        downloadImage(url: url)
    }
    
    private func downloadImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if error == nil {
                    let downloadedImage = UIImage(data: data!)
                    self.image = downloadedImage
                } else {
                    print("Error downloading image: \(error)")
                    
                    self.image = self.placeholderImage
                }                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("Requesting image...")

                self.downloadImage(url: url)
            }
        }
        
        task.resume()
    }
}
