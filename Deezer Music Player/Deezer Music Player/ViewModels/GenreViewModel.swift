//
//  GenreViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit


protocol GenreViewModelInterface {
    var view: GenreView? {get set}
    func viewDidLoad()
}

class GenreViewModel: GenreViewModelInterface {
   
    var arr: GenreRespone?
    weak var view: GenreView?
    
    init() {
        startQuery()
    }
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    func startQuery() {
        NetworkManager.shared.fetchGenre {[weak self] response in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    self.arr = success
                    self.view?.mainCollectionView.reloadData()
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func segueToArtistOfGenre(id: String) {
        NetworkManager.shared.fetchGenreArtist( catagoryID: id) {[weak self] response in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let success):
                DispatchQueue.main.async {

                    
                    let vc = GenreArtistsView()
                    vc.viewModel.data = success
                    self.view?.navigationController?.pushViewController(vc, animated: true)
                }

            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
