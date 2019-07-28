//
//  MenuViewController.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

final class MenuViewController: UITabBarController {
    
    private let defaultIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        configureTabBar()
    }
    
    private func configureTabBar() {
        var controllersList = [UIViewController]()
        
        for item in MenuItem.all {
            if let controller = item.initialController {
                controller.tabBarItem = UITabBarItem(title: item.title,
                                                     image: item.image,
                                                     tag: item.rawValue)
                controllersList.append(controller)
            }
        }
        
        setViewControllers(controllersList, animated: false)
        selectedIndex = defaultIndex
    }
    
}
