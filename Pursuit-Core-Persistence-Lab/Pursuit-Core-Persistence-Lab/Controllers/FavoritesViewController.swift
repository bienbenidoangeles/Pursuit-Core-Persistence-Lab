//
//  FavoritesViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    private var favorites = [Photo](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureRefreshControl()
        delegatesAndDataSources()
    }
    
    func configureRefreshControl(){
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func delegatesAndDataSources(){
        tableView.dataSource = self
    }
    
    @objc
    func loadData(){
        do {
            try favorites = PersistanceHelper.load()
        } catch {
            self.showAlert(title: "Failed to load data", message: "\(error)")
        }
    }


}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritedPhotoCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = "Id: \(favorite.id)"
        cell.detailTextLabel?.text = "User: \(favorite.user)"
        cell.imageView?.getImage(with: favorite.previewURL, completion: { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(systemName: "exclaimationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        })
        return cell
    }
    
    
}
