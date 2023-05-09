//
//  CatagoryArtistResponse.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation


// MARK: - CatagoryArtistResponse
struct CatagoryArtistResponse: Codable {
    let data: [CatagoryArtistResponseDatum]?
}

// MARK: - Datum
struct CatagoryArtistResponseDatum: Codable {
    let id: Int?
    let name: String?
    let picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let radio: Bool?
    let tracklist: String?
    let type: TypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type
    }
}
