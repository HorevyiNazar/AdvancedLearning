//
//  ScrollViewOffsetPreferenceKey.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14.11.2023.
//

import SwiftUI

struct ScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> ())  -> some View {
        self
            .background(
                GeometryReader{ geo in
                    Text("")
                        .preference(key: ScrollViewPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKey: View {
    
    let title: String = "New title here"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 75.0)
                    .onScrollViewOffsetChange { offset in
                        self.scrollViewOffset = offset
                    }
                
                content
                
            }
            .padding()
        }
        .overlay (Text("\(scrollViewOffset)"))
        .overlay ( navBar.opacity(scrollViewOffset < 40.0 ? 1.0 : 0.0), alignment: .top)
    }
}

#Preview {
    ScrollViewOffsetPreferenceKey()
}

extension ScrollViewOffsetPreferenceKey {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var content: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 300)
        }
    }
    private var navBar: some View {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
    }
}
