//
//  ArtistAlbumResponse.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation


// MARK: - ArtistAlbumResponse
struct ArtistAlbumResponse: Codable {
    let data: [ArtistAlbumDatum]?
    let total: Int?
    let next: String?
}

// MARK: - Datum
struct ArtistAlbumDatum: Codable {
    let id: Int?
    let title: String?
    let link, cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let genreID, fans: Int?
    let releaseDate: String?
    let recordType: RecordTypeEnum?
    let tracklist: String?
    let explicitLyrics: Bool?
    let type: RecordTypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case genreID = "genre_id"
        case fans
        case releaseDate = "release_date"
        case recordType = "record_type"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
        case type
    }
}

enum RecordTypeEnum: String, Codable {
    case album = "album"
    case ep = "ep"
    case single = "single"
}
