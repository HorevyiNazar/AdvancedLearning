//
//  AppTabBarView.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 15.11.2023.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "Home"
    @State private var tabSelection: TabBarItem = .home
    
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)).padding()
                .tabBarItem(tab: .home, selection: $tabSelection)
            Color.red.clipShape(RoundedRectangle(cornerRadius: 10)).padding()
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            Color.green.clipShape(RoundedRectangle(cornerRadius: 10)).padding()
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
        }
    }
}

#Preview {
    AppTabBarView()
}

extension AppTabBarView {
    private var AppTabBar: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
