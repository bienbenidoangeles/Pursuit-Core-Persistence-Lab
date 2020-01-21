//
//  DetailViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoDataLabel: UILabel!
    
    var passedObj: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
        
    @IBAction func favoriteButtonPressed(_ sender: UIButton){
        //save favorited podcast
        guard let validPhoto = passedObj else {
            fatalError("failed to unwrap passed photo")
        }
        let savedPhoto = Photo(largeImageURL: validPhoto.largeImageURL, webFormatHeight: validPhoto.webFormatHeight, webFormatWidth: validPhoto.webFormatWidth, likes: validPhoto.likes, views: validPhoto.views, comments: validPhoto.comments, webFormatURL: validPhoto.webFormatURL, tags: validPhoto.tags, downloads: validPhoto.downloads, user: validPhoto.user, previewURL: validPhoto.previewURL, favorited: true)
        
        
    }
    
    func configureData(){
        guard let validPhoto = passedObj else {
            fatalError("failed to unwrap passed photo")
        }
        photoImageView.getImage(with: validPhoto.largeImageURL) {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.photoImageView.image = UIImage(named: "exclaimationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            }
        }
        photoDataLabel.text = "Likes: \(validPhoto.likes)\nViews: \(validPhoto.views)\nComments:\(validPhoto.comments)\nTags:\(validPhoto.tags)\nUser\(validPhoto.user)"
    }

}
