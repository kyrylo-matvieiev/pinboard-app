//
//  UIViewController+Storyboard.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

extension UIViewController {
    static func fromStoryboard(type: StrotyboardType) -> Self? {
        func instantiateVC<T: UIViewController>() -> T? {
            return UIStoryboard(name: type.name, bundle: .main)
                .instantiateViewController(withIdentifier: String(describing: self)) as? T
        }
        return instantiateVC()
    }
}
