//
//  PhotosModel.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Bienbenido Angeles on 1/21/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct PhotoData: Codable {
    let totalHits: Int
    let hits: [Photo]
}

struct Photo: Codable {
    let largeImageURL: String
    let webFormatHeight: Int
    let webFormatWidth: Int
    let likes: Int
    let id:Int
    let views: Int
    let comments: Int
    let webFormatURL: String
    let tags: String
    let downloads: Int
    let user: String
    let previewURL: String
    var favorited: Bool?
}
