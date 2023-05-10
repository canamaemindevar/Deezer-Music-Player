//
//  ArtistView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//


import UIKit

protocol ArtistViewInterface {
    func prepare()
}

class ArtistView: UIViewController {
    
    
    lazy var viewModel = ArtistViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .clear
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        tableView.layer.cornerRadius = 0
        
        return tableView
    }()
    
    override func viewDidLoad() {
        viewModel.view = self
        viewModel.viewDidLoad()
        super.viewDidLoad()

    }

}

extension ArtistView: ArtistViewInterface {
    func prepare() {
        view.addSubview(tableView)
        
        title = "Artist"
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewHeader = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 5))
        guard let url = viewModel.arr?.data?.first?.coverMedium else {
            return
        }
        tableViewHeader.imageView.sd_setImage(with: URL(string: url) )
        self.tableView.tableHeaderView = tableViewHeader
    }
    
    
}

extension ArtistView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arr?.data?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        if let data = viewModel.arr?.data?[indexPath.row] {
            cell.config(datum: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let id = viewModel.arr?.data?[indexPath.row].id else {
            return
        }
        viewModel.segueToAlbum(id: String(id), picUrl: viewModel.arr?.data?.first?.coverMedium ?? "")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
