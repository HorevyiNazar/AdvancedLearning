//
//  PropertyWrapperBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 11/01/2024.
//

import SwiftUI

extension FileManager {
    static func documentsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}
@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    let key: String
    
    var wrappedValue: String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
   
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String ,_ key: String) {
        self.key = key
        do {
            title = try String(contentsOf: FileManager.documentsPath(key: key), encoding: .utf8)
            print("Succes Read")
        } catch {
            title = wrappedValue
            print("Error read: \(error)")
        }
    }
    
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentsPath(key: key), atomically: false, encoding: .utf8)
            title = newValue
//            print(NSHomeDirectory())
            print("Succes")
        } catch  {
            print("Error")
        }
    }
}

struct PropertyWrapperBootCamp: View {
    @FileManagerProperty("custom_title_1") private var title: String = "Starting text"
    @FileManagerProperty("custom_title_2") private var title2: String = "starting text 2"
    @FileManagerProperty("custom_title_3") private var title3: String = "starting text 3"
//    var fileManagerProperty = FileManagerProperty()
    @State private var subtitle: String = "SUBTITLE"
    
    var body: some View {
        VStack(spacing: 40) {
            Text(title).font(.largeTitle)
            Text(title2).font(.largeTitle)
            Text(title3).font(.largeTitle)
            PropertyWrapperChildView(subtitle: $subtitle)
            
            Button("Ckick me 1") {
                title = "title"
            }
            Button("Ckick me 2") {
                title = "title 2"
                title2 = "some random title"
            }
        }
    }
}

struct PropertyWrapperChildView: View {
    
    @Binding var subtitle: String
    
    var body: some View {
        Button(action: {
            subtitle = "Another title"
        }, label: {
            Text(subtitle).font(.largeTitle)
        })
    }
}

#Preview {
    PropertyWrapperBootCamp()
}
