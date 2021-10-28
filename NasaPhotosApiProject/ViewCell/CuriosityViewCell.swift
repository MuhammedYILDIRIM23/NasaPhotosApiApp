//
//  CollectionViewCell.swift
//  NasaPhotosApiProject
//
//  Created by Muhammed YILDIRIM  on 24.10.2021.
//

import UIKit

class CuriosityViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var collectionCellImage: UIImageView!
    
    
    
    func configure(with urlstring: String) {
        guard let url = URL(string: urlstring) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.collectionCellImage.image = image
            }
        }.resume()
    }
    
    
}
