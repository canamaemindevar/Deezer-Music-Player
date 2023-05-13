//
//  FavoriSongsView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 11.05.2023.
//
import UIKit.UITableView
import AVKit

protocol FavoriSongsViewInterface {
    func prepare()
}

class FavoriSongsView: UIViewController {

    var auidioPlayer = AVPlayer()
    var playerItem:AVPlayerItem?
    var url = URL(string: "")
    lazy var viewModel = FavoriSongsViewModel()
    
    //MARK: - Components
    
     let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        tableView.layer.cornerRadius = 0
        
        return tableView
    }()
    
    //MARK: - Life Cycle
    
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

//MARK: - FavoriSongsViewInterface

extension FavoriSongsView: FavoriSongsViewInterface {
    func prepare() {
        view.addSubview(tableView)
        self.tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    
}

//MARK: - SongPlayAble

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

//MARK: - TableView funcs

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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    
        guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else {
            return
        }
        cell.playStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else {
            return
        }
        cell.playOrStop()

    }
    
    
    
}
