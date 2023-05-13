//
//  GenreArtistsCell.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit
import SDWebImage

class GenreArtistsCell: UICollectionViewCell {
    
    static let identifier = "GenreArtistsCell"
    
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        return iv
    }()
    private let nameLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.textColor = .white
        sView.font = .boldSystemFont(ofSize: 20)
        return sView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        self.imageView.frame = bounds
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
       
        
    }
   public func configCell(datum: CatagoryArtistResponseDatum) {
       guard let url = datum.pictureMedium else {
           return
       }
       imageView.sd_setImage(with: URL(string: url) )
        nameLabel.text = datum.name
    }
}

