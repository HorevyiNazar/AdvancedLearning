//
//  GeometryPreferenceKey.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14.11.2023.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue.background(ignoresSafeAreaEdges: .bottom))
            Spacer()
            HStack {
                Rectangle()
                GeometryReader(content: { geometry in
                    Rectangle()
                        .updateRectangleSize(size: geometry.size)
                    
                })
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

#Preview {
    GeometryPreferenceKey()
}

extension View {
    func updateRectangleSize(size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
