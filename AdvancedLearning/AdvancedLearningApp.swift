//
//  AdvancedLearningApp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 09.11.2023.
//

import SwiftUI

@main
struct AdvancedLearningApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        
       // let userIssignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        let userIssignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        //let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
        //let userIssignedIn: Bool = value == "true" ? true : false
        self.currentUserIsSignedIn = userIssignedIn
        
    }

    var body: some Scene {
        WindowGroup {
            PropertyWrapperBootCamp()
        }
    }
}
