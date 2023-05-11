//
//  SongsViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

protocol SongsViewModelInterface {
    var view: SongsView? {get set}
    func viewDidLoad()
}

class SongsViewModel: SongsViewModelInterface {
    
   var arr: SongsResponse?
   var favIdArr: [Int] = []
   var albumPicUrl: String? 
    
   weak var view: SongsView?
    
    init() {
        fetchFavsFromCoreData()
    }

    
    func viewDidLoad() {
        view?.prepare()
    }
    
    private func fetchFavsFromCoreData() {
        CoreDataManager.shared.getDataForFavs { response in
            switch response {
            case .success(let success):
                success.forEach { element in
                    print("Element: \(element)")
                    self.favIdArr.append(element.id ?? 0)
                    print("ID array: - \(element.id)")
                }
            case .failure(let failure):
                print("Error with fetching core data favs: \(failure)" )
            }
        }
    }
    
    
}
