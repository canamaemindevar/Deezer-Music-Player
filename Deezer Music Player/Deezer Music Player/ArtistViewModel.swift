//
//  ArtistViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

protocol ArtistViewModelInterface {
    var view: ArtistView? {get set}
    func viewDidLoad()
}

class ArtistViewModel: ArtistViewModelInterface {
    
   var arr: ArtistAlbumResponse?
    
   weak var view: ArtistView?
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    
}
