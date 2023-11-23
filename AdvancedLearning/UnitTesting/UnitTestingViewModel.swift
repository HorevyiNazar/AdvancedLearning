//
//  UnitTestingViewModel.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 23/11/2023.
//

import Foundation
import SwiftUI

@Observable
class UnitTestingViewModel {
    var isPremium: Bool
    var dataArray: [String] = []
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        self.dataArray.append(item)
    }
}
