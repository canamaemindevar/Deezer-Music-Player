//
//  TabbarController.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit.UITabBar

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


            let vc1 = UINavigationController(rootViewController: GenreView())
            let vc2 = UINavigationController(rootViewController: FavoriSongsView())
            
            vc1.tabBarItem.image = UIImage(systemName: "music.note")
            vc2.tabBarItem.image = UIImage(systemName: "star")
            
            vc1.title = "Katagoriler"
            vc2.title = "Favoriler"
            
            tabBar.tintColor = .label
            
            setViewControllers([vc1,vc2], animated: true)
            }
    
}
