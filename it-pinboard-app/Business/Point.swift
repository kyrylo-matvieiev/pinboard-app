//
//  Point.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation

fileprivate enum Keys {
    static let kName = "name"
    static let kLatitude = "latitude"
    static let kLongitude = "longitude"
}

struct Point {
    var id: String? = nil
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(id: String, dict: [String: Any]) {
        guard let name = dict[Keys.kName] as? String,
            let latitude = dict[Keys.kLatitude] as? Double,
            let longitude = dict[Keys.kLongitude] as? Double
            else { return nil }
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Point {
    func convertToDict() -> [String: Any] {
        return [Keys.kName: self.name,
                Keys.kLatitude: self.latitude,
                Keys.kLongitude: self.longitude]
    }
}
