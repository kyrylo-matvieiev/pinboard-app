//
//  StoryboardType.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Foundation

enum StrotyboardType {
    case main
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }
}
