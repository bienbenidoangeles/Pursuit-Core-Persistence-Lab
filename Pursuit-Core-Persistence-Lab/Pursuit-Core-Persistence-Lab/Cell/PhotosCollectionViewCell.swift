//
//  PhotosCollectionViewCell.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import ImageKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photosImageView: UIImageView!
    
    func configureCell(with imageURL: String){
        photosImageView.getImage(with: imageURL) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.photosImageView.image = UIImage(named: "exclaimationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photosImageView.image = image
                }
                
            }
        }
    }
}
