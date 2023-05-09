//
//  GenreView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit

protocol GenreViewInterface: AnyObject {
    func prepare()
}

class GenreView: UIViewController {
   
    
    private lazy var viewModel = GenreViewModel()
    
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
        collection.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        viewModel.view = self
        viewModel.viewDidLoad()
        super.viewDidLoad()

    }


}

extension GenreView: GenreViewInterface {
    func prepare() {
        view.addSubview(mainCollectionView)
        view.backgroundColor = .systemBackground
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainCollectionView.trailingAnchor, multiplier: 3),
            mainCollectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

       
    }
    
    
}

extension GenreView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.arr?.data.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let data = viewModel.arr?.data[indexPath.item]  {
            cell.configCell(datum: data)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(viewModel.arr?.data[indexPath.item].id)
        print(viewModel.arr?.data[indexPath.item].name)
        
    }
    
}


