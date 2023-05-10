//
//  SongView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit
import AVKit

protocol SongsViewInterface {
    func prepare()
}

protocol SongPlayAble {
    func playOrStop()
    func setMusic(songUrl: String)
    var auidioPlayer: AVPlayer { get set }
    var playerItem:AVPlayerItem? { get set }
}

class SongsView: UIViewController {

    var auidioPlayer = AVPlayer()
    var playerItem:AVPlayerItem?
    var url = URL(string: "")
    var delegate: SongCellInterface?
     lazy var viewModel = SongsViewModel()
    
    private let tableView: UITableView = {
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
    

}

extension SongsView: SongsViewInterface {
    func prepare() {
        view.addSubview(tableView)
        self.tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    
}

extension SongsView: SongPlayAble {
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
    
  
//    @objc func playerDidFinishPlaying(sender: Notification) {
//        auidioPlayer.pause()
//      //  playOrStop()
//        auidioPlayer.replaceCurrentItem(with: nil)
//    }
    
}

extension SongsView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arr?.data?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            return UITableViewCell()
        }
        if let data = viewModel.arr?.data?[indexPath.row] {
            cell.config(datum: data, albumImageUrl: viewModel.albumPicUrl ?? "")
        }
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}

