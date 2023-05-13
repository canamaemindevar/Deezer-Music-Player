//
//  FavoriSongsViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 11.05.2023.
//

import Foundation

protocol FavoriSongsViewModelInterface {
    var view: FavoriSongsView? {get set}
    func viewDidLoad()
    func viewDidAppear()
}

class FavoriSongsViewModel: FavoriSongsViewModelInterface {

   
   var favArr: [SongsResponseDatum] = []
    
   weak var view: FavoriSongsView?
    

    
    func viewDidLoad() {
        view?.prepare()
    }
    func viewDidAppear() {
        fetchFavsFromCoreData()
    }
    
    private func fetchFavsFromCoreData() {
        CoreDataManager.shared.getDataForFavs { [weak self] response in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let success):
                self.favArr = []
                success.forEach { element in
                    
                    self.favArr.append(element)
                }
                DispatchQueue.main.async {
                    self.view?.tableView.reloadData()
                }
            case .failure(let failure):
                print("Error with fetching core data favs: \(failure)" )
            }
        }
    }
    
    
}
