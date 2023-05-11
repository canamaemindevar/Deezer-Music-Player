//
//  FavoriSongsView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 11.05.2023.
//
import UIKit
import AVKit

protocol FavoriSongsViewInterface {
    func prepare()
}

class FavoriSongsView: UIViewController {

    var auidioPlayer = AVPlayer()
    var playerItem:AVPlayerItem?
    var url = URL(string: "")
     lazy var viewModel = FavoriSongsViewModel()
    
     let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        tableView.layer.cornerRadius = 0
        
        return tableView
    }()
    override func viewDidLoad() {
        
        viewModel.view = self
        viewModel.viewDidLoad()
        super.viewDidLoad()
     
  
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
        super.viewDidAppear(animated)
    }
    

}

extension FavoriSongsView: FavoriSongsViewInterface {
    func prepare() {
        view.addSubview(tableView)
        self.tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    
}

extension FavoriSongsView: SongPlayAble {
    func playOrStop() {
        if auidioPlayer.rate == 0 {
            auidioPlayer.play()
        } else {
            auidioPlayer.pause()
            
        }
    }
    
    func setMusic( songUrl: String) {
        url = URL(string: songUrl)
        playerItem = AVPlayerItem(url: url!)
        auidioPlayer = AVPlayer(playerItem: playerItem)
        playOrStop()
    }
    

    
}

extension FavoriSongsView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            return UITableViewCell()
        }

        let data = viewModel.favArr[indexPath.row]
        cell.config(datum: data, albumImageUrl: data.imageUrl ?? "", isFavedSong: true)
       
         
        cell.songDelegate = self
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
