//
//  UnitTestingBootCampView.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 23/11/2023.
//

import SwiftUI

/*
 1. Unit Tests
 - test the logic in app
 
 2. UI Test
 = test the UI in app
 */


struct UnitTestingBootCampView: View {
    
    private var vm: UnitTestingViewModel
    
    init(isPremium: Bool) {
        vm = UnitTestingViewModel(isPremium: isPremium)
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootCampView(isPremium: true)
}
