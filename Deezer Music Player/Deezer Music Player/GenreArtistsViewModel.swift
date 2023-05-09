//
//  GenreArtistsViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

protocol GenreArtistsViewModelInterface {
    var view: GenreArtistsView? {get set}
    func viewDidLoad()
}


class GenreArtistsViewModel: GenreArtistsViewModelInterface {
    
    var data: CatagoryArtistResponse?
    var view: GenreArtistsView?
    
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    
}
