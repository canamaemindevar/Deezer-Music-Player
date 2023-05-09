//
//  SongView.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit

protocol SongsViewInterface {
    func prepare()
}

class SongsView: UIViewController {

    
    
     lazy var viewModel = SongsViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    }
    
    
}

extension SongsView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arr?.data?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  viewModel.arr?.data?[indexPath.row].title
        return cell
    }
    
    
}

