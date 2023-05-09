//
//  NetworkHelper.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

enum ErrosTypes: String, Error {
    
    case invalidUrl = "InvalidUrl"
    case noData = "No data"
    case invalidRequest = "Invalid request"
    case generalError = "General Error"
    case parsingError = "Parsing Error"
    case responseError = "Response Error"

}

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    
}

enum Endpoint {
    case genre
    case artist
    case artistsWithCatogry(id: String)
    case artistAlbums(id:String)
    case songs(id: String)
}

extension Endpoint: EndpointProtocol {
   
    var baseURL: String {
        return "https://api.deezer.com"
    }
    var path: String {
        switch self {
        case .genre: return "/genre"
        case .artist: return "/artist"
        case .artistsWithCatogry(id: let id): return "/genre/\(id)/artists"
        case .artistAlbums(id: let id): return "/artist/\(id)/albums"
        case .songs(id: let id): return "/album/\(id)/tracks"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .genre: return .get
        case .artist: return .get
        case .artistsWithCatogry: return .get
        case .artistAlbums: return .get
        case .songs: return .get
        }
    }
    
    var header: [String : String]? {
//        var header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
//        return header
        return nil
    }
    
    var parameters: [String : Any]? {
    
        return nil
    }
    
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }


        //Add Path
        components.path = path
        
        //Create request
     
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }
        
        
        //Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
