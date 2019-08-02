//
//  POIItem.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 8/1/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation
import GoogleMaps

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}
