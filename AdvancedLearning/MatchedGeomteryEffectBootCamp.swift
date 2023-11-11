//
//  MatchedGeomteryEffectBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 11.11.2023.
//

import SwiftUI

struct MatchedGeomteryEffectBootCamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeomteryEffectExample2()
}

struct MatchedGeomteryEffectExample2: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "categoryBackground", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10.0)
                    }
                    Text(category)
                        .foregroundStyle(selected == category ? Color.red : Color.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    if selected == category {
                        withAnimation(.spring()) {
                            selected = ""
                        }

                    } else{
                        withAnimation(.spring()) {
                            selected = category
                        }
                    }
                  
                }
            }
        }
        .padding()
    }
}
