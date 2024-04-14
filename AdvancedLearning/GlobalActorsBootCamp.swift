//
//  GlobalActorsBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14/04/2024.
//

import SwiftUI

@globalActor struct MyFirstGlobalActor {
    
    static var shared = MyNewDataManager()
    
}

actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Three", "Four", "Five"]
    }
    
}

class GlobalActorsBootCampViewModel: ObservableObject {
    // MainActor ensures that the code will run on the Main thread
    @MainActor @Published var dataArray: [String] = []
    let manager = MyFirstGlobalActor.shared
    
    @MyFirstGlobalActor 
    func getData() async {
        
        // HEAVY COMPLEX METHODS
        
        let data = await manager.getDataFromDatabase()
        await MainActor.run {
            self.dataArray = data
        }
    }
}

struct GlobalActorsBootCamp: View {
    
    @StateObject private var vm = GlobalActorsBootCampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await vm.getData()
        }
    }
}

#Preview {
    GlobalActorsBootCamp()
}
