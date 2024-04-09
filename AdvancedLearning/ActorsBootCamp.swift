//
//  ActorsBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 09/04/2024.
//

import SwiftUI

// 1. What is the problem that actor are solving
// 2. How as this problem solved prior to actors
// 3. Actors can solve the problem

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() { }
    
    var data: [String] = []
    // Solving the issue without Actor
    private let lock = DispatchQueue(label: "com.MyApp.MyDataManager")
    // Old way -> Using completionHandler
    func getRandomData(completionHandler: @escaping (_ title: String?) -> ()) {
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            
            completionHandler(self.data.randomElement())
        }
    }
}

actor MyActorManager {
    
    static let instance = MyActorManager()
    private init() { }
    
    var data: [String] = []
    
    nonisolated let myRandomText = "qwerty"
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    nonisolated func getSavedData() -> String {
        return "New data"
    }
}

struct HomeView: View {
    
    let manager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear(perform: {
            let newString = manager.getSavedData()
            Task { await manager.data }
        })
        .onReceive(timer, perform: { _ in
            // 1
            /*
            DispatchQueue.global(qos: .background).async {
                // 1
                manager.getRandomData { title in
                    if let data = title {
                        DispatchQueue.main.async {
                            self.text = data
                        }
                    }
                }
            }
            */
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
        })
    }
}
struct BrowseView: View {
    
    let manager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.3).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            // 1
            /*
            DispatchQueue.global(qos: .background).async {
                // 1
                manager.getRandomData { title in
                    if let data = title {
                        DispatchQueue.main.async {
                            self.text = data
                        }
                    }
                }
            }
            */
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
        })
    }
}

struct ActorsBootCamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorsBootCamp()
}
