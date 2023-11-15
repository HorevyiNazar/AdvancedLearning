//
//  CustomTabBarContainerView.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 15.11.2023.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
   
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []

    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0, content: {
            ZStack {
                content
            }
        })
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
        CustomTabBarView(tabs: tabs, selection: $selection)
    }
}

#Preview {
    CustomTabBarContainerView(selection: .constant(.home)) {
        Color.red
    }
}
