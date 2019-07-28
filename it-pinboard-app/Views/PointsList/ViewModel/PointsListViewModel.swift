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
    var refreshingStateCallback: (RefreshingState) -> Void? = { _ in }
    var pointsListCallback: () -> Void? = {}
    
    var pointsList = [Point]() {
        didSet {
            pointsListCallback()
        }
    }
    
    func load() {
        refreshingStateCallback(.start)
        let point = [Point(id: 1, name: "Home", latitude: "044323", longitude: "3234432")] //[Point]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.pointsList = point
            self.refreshingStateCallback(.end)
        }
    }
}
