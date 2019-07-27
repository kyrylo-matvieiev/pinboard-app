//
//  XibLoadable.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

protocol XibLoadable {
    static func fromXib() -> Self?
}

extension XibLoadable where Self: UIView {
    static func fromXib() -> Self? {
        func instantiateXib<T: UIView>() -> T? {
            let nib = UINib(nibName: String(describing: self), bundle: .main)
            return nib.instantiate(withOwner: self, options: nil).first as? T
        }
        return instantiateXib()
    }
}
