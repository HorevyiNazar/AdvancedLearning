//
//  SendableBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 16/06/2024.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDatabase(userInfo: MyClassUserInfo) {
        
    }
    
}

struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.MyAppName")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(newName: String) {
        queue.async {
            self.name = newName
        }
    }
}

class SendableBootCampViewmodel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo () async {
        
        let info = MyClassUserInfo(name: "info")
        
        await manager.updateDatabase(userInfo: info)
    }
}

struct SendableBootCamp: View {
    
    @StateObject private var vm = SendableBootCampViewmodel()
    
    var body: some View {
        Text("Hello, World!")
            .task {
                
            }
    }
}

#Preview {
    SendableBootCamp()
}
