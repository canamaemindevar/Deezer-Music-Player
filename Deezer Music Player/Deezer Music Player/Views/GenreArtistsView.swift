//
//  GenreArtists.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit.UICollectionView

protocol GenreArtistsInterface {
    func prepare()
}

class GenreArtistsView: UIViewController {

    
    
    lazy var viewModel = GenreArtistsViewModel()
    
    //MARK: - Components
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width
        layout.itemSize = .init(width: size/2.4, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 5
        collection.backgroundColor = .clear
        collection.register(GenreArtistsCell.self, forCellWithReuseIdentifier: GenreArtistsCell.identifier)
        return collection
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        viewModel.view = self
        viewModel.viewDidLoad()
        super.viewDidLoad()
    }

}

//MARK: - GenreArtistsInterface

extension GenreArtistsView: GenreArtistsInterface {
    func prepare() {
        view.addSubview(mainCollectionView)
        view.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainCollectionView.trailingAnchor, multiplier: 3),
            mainCollectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    
}

//MARK: - ColletionView Funcs

extension GenreArtistsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data?.data?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: GenreArtistsCell.identifier, for: indexPath) as? GenreArtistsCell else {
            return UICollectionViewCell()
        }
        if let data = viewModel.data?.data?[indexPath.item]  {
            cell.configCell(datum: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard  let id = viewModel.data?.data?[indexPath.item].id else {
            return
        }
        viewModel.segueToArtist(id: String(id))
    }
    
    
}

