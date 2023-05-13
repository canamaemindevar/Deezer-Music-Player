//
//  SongCell.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 10.05.2023.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation


final class SongCell: UITableViewCell {
    
    static let identifier = "SongCell"
    
   
    var songDelegate: SongPlayAble?
    var songsResponseDatum: SongsResponseDatum?
    var isFavedSong = false
    var albumImageUrl: String?
    
    //MARK: - Components
    
    private let myView: UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .label
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 10
        iv.layer.borderColor = CGColor(red: 120, green: 30, blue: 40, alpha: 1)
        iv.layer.shadowOpacity = 1
        iv.layer.borderWidth = 4
        return iv
    }()
    
    private let albumimageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private let saveButton: UIButton = {
        let sView = UIButton()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.setImage(UIImage(systemName: "bolt.heart"), for: .normal)
        sView.tintColor = .red
        return sView
    }()
    
    private let nameLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = .label
        sView.font = .boldSystemFont(ofSize: 20)
        sView.textAlignment = .left
        sView.numberOfLines = 0
        return sView
    }()
    public let playStopButton: UIButton = {
        let sView = UIButton()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.tintColor = .label
        sView.setImage(UIImage(systemName: "play.fill"), for: .normal)
        sView.isEnabled = false
        return sView
    }()
    private let timeLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = .label
        sView.font = .italicSystemFont(ofSize: 14)
        sView.textAlignment = .left
        return sView
    }()
    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        return sView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConts()
        saveButton.addTarget(self, action: #selector(saveToCoreData), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Conts
    private func setupConts() {
        let size = 50.0
        backgroundColor = .clear
        contentView.addSubview(myView)
        contentView.addSubview(albumimageView)
        contentView.addSubview(stackview)
        contentView.addSubview(saveButton)
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(playStopButton)
        
        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            myView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: myView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: myView.bottomAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            albumimageView.leadingAnchor.constraint(equalToSystemSpacingAfter: myView.leadingAnchor, multiplier: 0),
            albumimageView.topAnchor.constraint(equalToSystemSpacingBelow: myView.topAnchor, multiplier: 0.5),
            myView.bottomAnchor.constraint(equalToSystemSpacingBelow: albumimageView.bottomAnchor, multiplier: 0.5),
            albumimageView.widthAnchor.constraint(equalTo: myView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: myView.topAnchor),
            saveButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: size),
            saveButton.widthAnchor.constraint(equalToConstant: size)
        ])
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: albumimageView.trailingAnchor, multiplier: 2),
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: myView.topAnchor, multiplier: 0),
            stackview.trailingAnchor.constraint(equalToSystemSpacingAfter: saveButton.leadingAnchor, multiplier: 1),
            stackview.bottomAnchor.constraint(equalToSystemSpacingBelow: myView.bottomAnchor, multiplier: 0)
        ])
    }

}
//MARK: - Config Func
extension SongCell {
    
    func config(datum:SongsResponseDatum, albumImageUrl: String, isFavedSong: Bool) {
        self.songsResponseDatum = datum
        albumimageView.sd_setImage(with: URL(string: "") )
        nameLabel.text = datum.title
        timeLabel.text = datum.link
        changeFavButtonImage(bool: isFavedSong)
        albumimageView.sd_setImage(with: URL(string: albumImageUrl) )
        self.albumImageUrl = albumImageUrl
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: songDelegate?.playerItem)
    }
}

//MARK: - Auido Funcs
extension SongCell {
    func changeButonImageToPlay() {
        playStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        songDelegate?.playOrStop()
    }
    
    func changeButonImageStop() {
        playStopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        songDelegate?.setMusic(songUrl: self.songsResponseDatum?.preview ?? "")
    }
    
    @objc  func playOrStop() {
        
        if playStopButton.currentImage == UIImage(systemName: "stop.fill") {
            changeButonImageToPlay()
        } else {
            changeButonImageStop()
        }
    }
    
    @objc private func playerDidFinishPlaying(sender: Notification) {
        songDelegate?.auidioPlayer.pause()
        changeButonImageToPlay()
        songDelegate?.auidioPlayer.replaceCurrentItem(with: nil)
    }
    @objc private func musicChanged(sender: Notification) {
        songDelegate?.auidioPlayer.replaceCurrentItem(with: nil)
        songDelegate?.auidioPlayer.pause()
    }
    

    
    func changeFavButtonImage(bool: Bool) {
        if bool == true {
            isFavedSong = bool
            saveButton.setImage(UIImage(systemName: "heart.slash.fill"), for: .normal)
        } else {
            isFavedSong = bool
            saveButton.setImage(UIImage(systemName: "bolt.heart"), for: .normal)
        }
    }


}

//MARK: - Core Data

extension SongCell {
    
    @objc private func  saveToCoreData() {
        guard let data = songsResponseDatum else {
            return
        }
        if isFavedSong == false {
            
            CoreDataManager.shared.saveCoreData(withModel: SongsResponseDatum(id: data.id,
                                                                              readable: data.readable,
                                                                              title: data.title,
                                                                              titleShort: data.titleShort,
                                                                              titleVersion: data.titleVersion,
                                                                              isrc: data.isrc,
                                                                              link: data.link,
                                                                              duration: data.duration,
                                                                              trackPosition: data.trackPosition,
                                                                              diskNumber: data.diskNumber,
                                                                              rank: data.rank,
                                                                              explicitLyrics: data.explicitLyrics,
                                                                              explicitContentLyrics: data.explicitContentLyrics,
                                                                              explicitContentCover: data.explicitContentCover,
                                                                              preview: data.preview,
                                                                              md5Image: data.md5Image,
                                                                              artist: data.artist,
                                                                              type: data.type,
                                                                              imageUrl: albumImageUrl))
            changeFavButtonImage(bool: true)
        } else {
            CoreDataManager.shared.deleteCoreData(with: data.id)
            changeFavButtonImage(bool: false)
            
        }
    }
}



