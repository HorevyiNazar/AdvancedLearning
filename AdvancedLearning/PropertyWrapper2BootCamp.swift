//
//  PropertyWrapper2BootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14/01/2024.
//

import SwiftUI

@propertyWrapper
struct Capitalized: DynamicProperty {
    
    @State private var value: String
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            value = newValue.capitalized
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}
@propertyWrapper
struct Uppercased: DynamicProperty {
    
    @State private var value: String
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            value = newValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
   
    var projectedValue: Binding<T?> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
    
    init(/*wrappedValue: T?, */_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("Succes Read")
        } catch {
            _value = State(wrappedValue: nil)
            print("Error read: \(error)")
        }
    }
    init(_ key: KeyPath<FileManagerValues, FileManagerKeypath<T>>) {
        let keypath = FileManagerValues.shared[keyPath: key]
        
        let key = keypath.key
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("Succes Read")
        } catch {
            _value = State(wrappedValue: nil)
            print("Error read: \(error)")
        }
    }
    
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            value = newValue
            print("Succes")
        } catch  {
            print("Error")
        }
    }
}

struct User: Codable {
    let name: String
    let age: Int
    let isPremium: Bool
}

struct FileManagerValues {
    static let shared = FileManagerValues()
    private init() {}
    
    let userProfile = FileManagerKeypath(key: "user_profile", type: User.self)
}

struct FileManagerKeypath<T: Codable> {
    let key: String
    let type: T.Type
}

import Combine

@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
   
//    var projectedValue: Binding<T?> {
//        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
//    }
    var projectedValue: CustomProjectedValue<T> {
        CustomProjectedValue(binding: Binding(get: { wrappedValue }, set: { wrappedValue = $0 }), publisher: publisher)
    }
    
    init(/*wrappedValue: T?, */_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("Succes Read")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("Error read: \(error)")
        }
    }
    init(_ key: KeyPath<FileManagerValues, FileManagerKeypath<T>>) {
        let keypath = FileManagerValues.shared[keyPath: key]
        
        let key = keypath.key
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("Succes Read")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("Error read: \(error)")
        }
    }
    
    private func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            value = newValue
            publisher.send(newValue)
            print("Succes")
        } catch  {
            print("Error")
        }
    }
}

struct CustomProjectedValue<T: Codable> {
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
}

struct PropertyWrapper2BootCamp: View {
    
    @Uppercased private var title: String = "Hello, world!"
//    @Capitalized private var title: String = "Hello, world!"
//    @FileManagerCodableProperty("user_profile") private var userProfile: User?
//    @FileManagerCodableProperty(\.userProfile) private var userProfile
    @FileManagerCodableStreamableProperty(\.userProfile) private var userProfile



    var body: some View {
        VStack(spacing: 40) {
            
            Button(title) {
                title = "new title"
            }
            
            SomeBindingView(userProfile: $userProfile.binding)
            Button(userProfile?.name ?? "no value") {
                userProfile = User(name: "Ricky", age: 100, isPremium: true)
            }
        }
        .onReceive($userProfile.publisher, perform: { newValue in
            print("Recieved new value: \(newValue)")
        })
        .task {
            for await newValue in $userProfile.stream {
                print("Streamed new value: \(newValue)")
            }
        }
    }
}

struct SomeBindingView: View {
    
    @Binding var userProfile: User?
    
    var body: some View {
        Button(userProfile?.name ?? "no value") {
            userProfile = User(name: "Nick", age: 100, isPremium: false)
        }
    }
}

#Preview {
    PropertyWrapper2BootCamp()
}
