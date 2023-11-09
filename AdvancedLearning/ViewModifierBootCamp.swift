//
//  ViewModifierBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 09.11.2023.
//

import SwiftUI

struct defaultButtonViewModifier: ViewModifier {
    
    let bcColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(bcColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(bcColor: Color = .blue) -> some View {
        modifier(defaultButtonViewModifier(bcColor: bcColor))
    }
}

struct ViewModifierBootCamp: View {
    
    var body: some View {
        VStack {
            Text("Hello world")
                .withDefaultButtonFormatting(bcColor: .orange)
            Text("Hello everyone")
                .withDefaultButtonFormatting()
            Text("Hello")
                .withDefaultButtonFormatting(bcColor: .yellow)
        }
    }
}

#Preview {
    ViewModifierBootCamp()
}
