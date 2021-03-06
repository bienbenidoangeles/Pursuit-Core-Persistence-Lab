//
//  PhotosAPIClient.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoAPIClient {
    static func getPhotos(with query: String, completion: @escaping (Result<[Photo], AppError>)->()){
        let queryMod = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let endPointURLString = "https://pixabay.com/api/?key=\(Secrets.apiKey)&q=\(queryMod)"
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let photoData = try JSONDecoder().decode(PhotoData.self, from: data)
                    let photo = photoData.hits
                    completion(.success(photo))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
