//
//  CustomBindingBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 28/12/2023.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
    
}

struct CustomBindingBootCamp: View {
    
    @State private var title: String = "Start"
    
    @State private var errorTitle: String? = nil
//    @State private var showError: Bool = false
    
    
    var body: some View {
        VStack {
            Text(title)
            
            ChildView(title: $title)
            
            ChildView2(title: title) { newValue in
                title = newValue
            }
            
            ChildView3(title: $title)
            
            ChildView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
        }
        
        
        Button("Click me") {
            errorTitle = "New error"
//            showError.toggle()
        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("OK") {
                
            }
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            if !newValue {
//                errorTitle = nil
//            }
//        })) {
//            Button("OK") {
//                
//            }
        }
    }


struct ChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onAppear {
//                title = "New title"
            }
    }
}

struct ChildView2: View {
    
    let title: String
    let setTitle: (String) -> Void
    
    var body: some View {
        Text(title)
            .onAppear(perform: {
//                setTitle("New Title2")
            })
    }
}

struct ChildView3: View {
    
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear(perform: {
                title.wrappedValue = "New title 3"
            })
    }
}

#Preview {
    CustomBindingBootCamp()
}
