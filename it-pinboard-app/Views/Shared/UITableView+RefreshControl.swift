//
//  UITableView+RefreshControl.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/29/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit

extension UITableView {
    func beginRefreshing() {
        if let refresh = refreshControl, !refresh.isRefreshing {
            setContentOffset(CGPoint(x: 0.0, y: contentOffset.y - refresh.frame.size.height), animated: true)
            refresh.layoutIfNeeded()
            refresh.beginRefreshing()
        }
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
        refreshControl?.isHidden = true
    }
}

enum RefreshingState {
    case start
    case end
}
