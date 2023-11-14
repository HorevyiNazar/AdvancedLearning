//
//  PreferenceKeyBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14.11.2023.
//

import SwiftUI

struct PreferenceKeyBootCamp: View {
    
    @State private var text: String = "Hello world"
    
    var body: some View {
        NavigationStack {
            VStack {
                SecondaryView(text: text)
//                    .preference(key: CustomTitleReferenceKey.self, value: "NewValue")
            }
            .navigationTitle("Navigation Title")
        }
        .onPreferenceChange(CustomTitleReferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View {
    func customTitle(text: String) -> some View {
        self.preference(key: CustomTitleReferenceKey.self, value: text)
    }
}

#Preview {
    PreferenceKeyBootCamp()
}

struct SecondaryView: View {
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear(perform: getData)
            .customTitle(text: newValue)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW value"
        }
    }
    
}

struct CustomTitleReferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
