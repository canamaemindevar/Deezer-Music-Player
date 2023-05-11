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
    
    
    func segueToAlbum(id: String, picUrl: String) {
        NetworkManager.shared.fetchAlbumSongs(albumId: id) {[weak self] response in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    let vc = SongsView()
                    vc.viewModel.arr = success
                    vc.viewModel.albumPicUrl = picUrl
                    self?.view?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
