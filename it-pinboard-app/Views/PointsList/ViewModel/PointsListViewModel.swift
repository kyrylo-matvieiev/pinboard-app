//
//  PointsListViewModel.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol PointsListViewModelType {
    func load()
    func deletePointAt(index: Int)
    
    var pointsList: [Point] { get }
    var pointsListCallback: () -> Void? { get set }
    var refreshingStateCallback: (RefreshingState) -> Void? { get set }
}

class PointsListViewModel: PointsListViewModelType {
    
    // MARK: - Properties
    
    private let pointNetworkService = PointNetworkService()
    
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
        guard let user = Auth.auth().currentUser else { return }
        refreshingStateCallback(.start)
        pointNetworkService.getPointLists(for: user) { [weak self] points in
            self?.pointsList = points
            self?.refreshingStateCallback(.end)
        }
    }
    
    func deletePointAt(index: Int) {
        guard let user = Auth.auth().currentUser else { return }
        guard let deletePointId = pointsList[index].id else { return }
        pointNetworkService.deletePoint(id: deletePointId, form: user) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
