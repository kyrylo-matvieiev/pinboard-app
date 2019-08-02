//
//  MapViewModel.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 8/1/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol MapViewModelType {
    func load()
    func savePoint(_ point: Point, completion: @escaping () -> Void)
    
    var points: [Point] { get }
    var pointsListCallback: () -> Void { get set }
}

class MapViewModel: MapViewModelType {
    var pointsListCallback: () -> Void = {}
    
    private let pointNetworkService = PointNetworkService()
    
    var points = [Point]() {
        didSet {
            pointsListCallback()
        }
    }
    
    func load() {
        guard let user = Auth.auth().currentUser else { return }
        pointNetworkService.getPointLists(for: user) { [weak self] points in
            self?.points = points
        }
    }
    
    func savePoint(_ point: Point, completion: @escaping () -> Void) {
         guard let user = Auth.auth().currentUser else { return }
        pointNetworkService.addPoint(point, to: user) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
