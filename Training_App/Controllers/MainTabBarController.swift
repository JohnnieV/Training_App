//
//  MainTabBarController.swift
//  Training_App
//
//  Created by Владимир Смирнов on 05.02.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen // цвет активных элементов
        tabBar.unselectedItemTintColor = .specialGray // цвет неактивных элементов
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }
    
    private func setupItems() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        let profileVC = ProfileViewController()
        
        setViewControllers([mainVC, statisticVC, profileVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        // ставим тайтлы элементам таббара
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"
        
        // ставим картинки элементам таббара
        items[0].image = UIImage(named: "tabBarMain")
        items[1].image = UIImage(named: "tabBarStatistic")
        items[2].image = UIImage(named: "tabBarProfile")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
}
