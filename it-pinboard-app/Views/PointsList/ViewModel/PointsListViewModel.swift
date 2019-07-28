//
//  PointsListViewModel.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation

protocol PointsListViewModelType {
    func load()
    
    var pointsList: [Point] { get }
    var pointsListCallback: () -> Void? { get set }
    var refreshingStateCallback: (RefreshingState) -> Void? { get set }
}

class PointsListViewModel: PointsListViewModelType {
    
    // MARK: - Properties
    
        // (Callbacks)
    
    var refreshingStateCallback: (RefreshingState) -> Void? = { _ in }
    var pointsListCallback: () -> Void? = {}
    
        // (Repository)
    
    var pointsList = [Point]() {
        didSet {
            pointsListCallback()
        }
    }
    
    // MARK: - Network
    
    func load() {
        refreshingStateCallback(.start)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
            self.refreshingStateCallback(.end)
        }
    }
}
