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
        NetworkManager.shared.fetchGenre { response in
            switch response {
            case .success(let success):
                print(success)
                DispatchQueue.main.async {
                    self.arr = success
                    self.view?.mainCollectionView.reloadData()
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
