//
//  SongsResponse.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

// MARK: - SongsResponse
struct SongsResponse: Codable {
    let data: [SongDatum]?
    let total: Int?
}

// MARK: - Datum
struct SongDatum: Codable {
    let id: Int?
    let readable: Bool?
    let title, titleShort, titleVersion, isrc: String?
    let link: String?
    let duration, trackPosition, diskNumber, rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: Md5Image?
    let artist: Artist?
    let type: DatumType?

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, type
    }
}

//MARK: - Artist
struct Artist: Codable {
    let id: Int?
    let name: Name?
    let tracklist: String?
    let type: ArtistType?
}

enum Name: String, Codable {
    case daftPunk = "Daft Punk"
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

enum Md5Image: String, Codable {
    case the2E018122Cb56986277102D2041A592C8 = "2e018122cb56986277102d2041a592c8"
}

enum DatumType: String, Codable {
    case track = "track"
}
