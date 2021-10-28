//
//  OpportunityViewCell.swift
//  NasaPhotosApiProject
//
//  Created by Muhammed YILDIRIM  on 28.10.2021.
//

import UIKit

class OpportunityViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
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
                self.imageView.image = image
            }
        }.resume()
    }
    
}
