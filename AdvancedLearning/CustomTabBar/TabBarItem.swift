//
//  TabBarItem.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 15.11.2023.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        }
    }
    var color: Color {
        switch self {
        case .home:
            return .red
        case .favorites:
            return .blue
        case .profile:
            return .green
        }
    }
}
