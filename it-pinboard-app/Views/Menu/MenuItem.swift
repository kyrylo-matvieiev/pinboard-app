//
//  MenuItem.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

fileprivate enum Localized {
    static let listTabTitle = NSLocalizedString("List", comment: "")
    static let mapTabTitle = NSLocalizedString("Map", comment: "")
    static let profileTabTitle = NSLocalizedString("Profile", comment: "")
}

enum MenuItem: Int {
    
    case pointsList = 0
    case map = 1
    case profile = 2
    
    static let all = [pointsList, map, profile]
    
    var title: String {
        switch self {
        case .pointsList:
          return Localized.listTabTitle
        case .map:
            return Localized.mapTabTitle
        case .profile:
            return Localized.profileTabTitle
        }
    }
    
    var image: UIImage? {
        switch self {
        case .pointsList:
            return #imageLiteral(resourceName: "list")
        case .map:
            return #imageLiteral(resourceName: "earth")
        case .profile:
            return #imageLiteral(resourceName: "profile")
        }
    }
    
    var initialController: UIViewController? {
        switch self {
        case .pointsList:
            return PointsListViewController.fromStoryboard(type: .main)
        case .map:
            return MapViewController.fromStoryboard(type: .main)
        case .profile:
            return ProfileViewController.fromStoryboard(type: .main)
        }
    }
}
