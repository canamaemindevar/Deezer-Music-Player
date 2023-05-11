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
   var albumPicUrl: String?
    
   weak var view: FavoriSongsView?
    
//    init() {
//        fetchFavsFromCoreData()
//    }

    
    func viewDidLoad() {
        view?.prepare()
    }
    func viewDidAppear() {
        fetchFavsFromCoreData()
    }
    
    private func fetchFavsFromCoreData() {
        CoreDataManager.shared.getDataForFavs { response in
            switch response {
            case .success(let success):
                self.favArr = []
                success.forEach { element in
                    print(element)
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
