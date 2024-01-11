//
//  KeypathsBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 11/01/2024.
//

import SwiftUI

struct MyDataModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

//struct MovieTitle {
//    let primary: String
//    let secondary: String
//}

extension Array {
    
   mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return  ascending ? (value1 < value2) : (value1 > value2)
        }
    }
    
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return  ascending ? (value1 < value2) : (value1 > value2)
        }
    }
    
}

struct KeypathsBootCamp: View {
    
    @AppStorage("user_count") var userCount: Int = 0
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        List {
            ForEach(dataArray) { item in
                VStack(alignment: .leading) {
                    Text(item.id)
                    Text(item.title)
                    Text("\(item.count)")
                    Text(item.date.description)
                }
                .font(.headline)
            }
        }
            .onAppear {
                var array = [
                    MyDataModel(title: "Three", count: 3, date: .distantFuture),
                    MyDataModel(title: "One", count: 1, date: .now),
                    MyDataModel(title: "Two", count: 2, date: .distantPast),
                ]
                
//                let newArray = array.sorted(by: { $0.count < $1.count })
//                let newArray = array.sorted(by: { $0[keyPath: \.count] < $1[keyPath: \.count]})
//                let newArray = array.customSorted()
//                let newArray = array.sortedByKeyPath(\.count, ascending: true)
                array.sortByKeyPath(\.count)
                dataArray = array
            }
    }
}

#Preview {
    KeypathsBootCamp()
}
