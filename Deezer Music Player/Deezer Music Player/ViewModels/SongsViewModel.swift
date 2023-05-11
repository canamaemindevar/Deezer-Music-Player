//
//  SongsViewModel.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import Foundation

protocol SongsViewModelInterface: AnyObject {
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
        CoreDataManager.shared.getDataForFavs { [weak self] response in
            switch response {
            case .success(let success):
                success.forEach { element in
                    self?.favIdArr.append(element.id )
                }
            case .failure(let failure):
                print("Error with fetching core data favs: \(failure)" )
            }
        }
    }
    
    
}
