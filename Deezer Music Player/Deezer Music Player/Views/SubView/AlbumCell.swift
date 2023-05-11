//
//  AlbumCell.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit
import SDWebImage

final class AlbumCell: UITableViewCell {
    
    static let identifier = "AlbumCell"
    
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
    
    private let nameLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = .label
        sView.numberOfLines = 0
        sView.font = .boldSystemFont(ofSize: 20)
        sView.textAlignment = .left
        return sView
    }()
    private let dateLabel: UILabel = {
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
        sView.alignment = .leading
        return sView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //translatesAutoresizingMaskIntoConstraints = false
        setupConts()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConts() {
        backgroundColor = .clear
        contentView.addSubview(myView)
        contentView.addSubview(albumimageView)
        contentView.addSubview(stackview)
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(dateLabel)
        
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
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: albumimageView.trailingAnchor, multiplier: 2),
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: myView.topAnchor, multiplier: 0),
            myView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 2),
            stackview.bottomAnchor.constraint(equalToSystemSpacingBelow: myView.bottomAnchor, multiplier: 0)
        ])
        
    }
    
    
    func config(datum:ArtistAlbumDatum) {
        guard let url = datum.coverMedium else {
            return
        }
        albumimageView.sd_setImage(with: URL(string: url) )
        nameLabel.text = datum.title
        dateLabel.text = datum.releaseDate
    }
}
