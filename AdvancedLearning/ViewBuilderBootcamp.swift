//
//  ViewBuilderBootcamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14.11.2023.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content:View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            content

            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content:View>:View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New title", description: "Hello", iconName: "heart.fill")
            
            HeaderViewRegular(title: "New title", description: nil, iconName: nil)
            
            HeaderViewGeneric(title: "Generic title") {
                HStack {
                    Text("Hi")
                    Image(systemName: "heart.fill")
                    Text("Hi")
                }
            }
            
            CustomHStack {
                Text("HI")
                Text("HI")
            }
            
            Spacer()
        }
    }
}

#Preview {
//    ViewBuilderBootcamp()
    LocalViewBuilder(type: .one)
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart.fill")
        }
    }
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}
