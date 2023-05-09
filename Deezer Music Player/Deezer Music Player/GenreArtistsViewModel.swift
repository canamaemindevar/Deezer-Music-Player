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
   weak var view: GenreArtistsView?
    
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    func segueToArtist(id: String) {
        NetworkManager.shared.fetchArtistAlbum(artistId: id) { response in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    let vc = ArtistView()
                    vc.viewModel.arr = success
                    
                    self.view?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}
