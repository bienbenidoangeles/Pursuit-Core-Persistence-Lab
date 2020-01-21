//
//  ViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/17/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var photos = [Photo](){
        didSet{
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData(with: "")
        delegatesAndDataSources()
    }

    private func delegatesAndDataSources(){
        searchBar.delegate = self
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    private func loadData(with query: String){
        PhotoAPIClient.getPhotos(with: query) { [weak self](result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let photo):
                self?.photos = photo
            }
        }
    }

}

extension PhotosViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text else {
            return
        }
        loadData(with: query)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacingV:CGFloat = 3
        let numberOfItemsV:CGFloat = 5
        let maxWidth = UIScreen.main.bounds.size.width
        let totalSpacingV = interItemSpacingV * numberOfItemsV
        let itemWidth : CGFloat = (maxWidth - totalSpacingV) / numberOfItemsV
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("failed to downcast to PhotoCollectionViewCell")
        }
        
        let photo = photos[indexPath.row]
        cell.configureCell(with: photo.previewURL)
        return cell
    }
}
