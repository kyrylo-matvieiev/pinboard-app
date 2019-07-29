//
//  Point.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/28/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation

class Point: Codable {
    var id: String? = nil
    var name: String
    var latitude: String
    var longitude: String
    
    init(name: String, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(id: String, dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let latitude = dict["latitude"] as? String,
            let longitude = dict["longitude"] as? String
            else { return nil }
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case name
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
    }
}
