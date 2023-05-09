//
//  TabbarController.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 9.05.2023.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


            let vc1 = UINavigationController(rootViewController: GenreView())
            
            
            vc1.tabBarItem.image = UIImage(systemName: "music.note")
           
            
            vc1.title = "Katagoriler"
            
            
            tabBar.tintColor = .label
            
            setViewControllers([vc1], animated: true)
            }
    
}
