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
   var albumPicUrl: String? 
    
   weak var view: SongsView?
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    
}
