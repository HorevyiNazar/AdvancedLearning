//
//  SubscriptsBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 16/01/2024.
//

import SwiftUI

struct MyTestStruct {
    let name: String
}

extension Array where Element == String {
    subscript(value: String) -> Element? {
        self.first(where: { $0 == value })
    }
}

struct SubscriptsBootCamp: View {
    
    @State private var myArray: [String] = ["one", "two", "three"]
    @State private var selectedItem: String? = nil
    
    var body: some View {
        VStack {
            ForEach(myArray, id: \.self) { string in
                Text(string)
            }
            
            Text("Selected: \(selectedItem ?? "none")")
        }
        .onAppear(perform: {
            let value = "two"
            
            selectedItem = myArray[value]
        })
    }
}

#Preview {
    SubscriptsBootCamp()
}
