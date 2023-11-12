//
//  CustomCurvesBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 12.11.2023.
//

import SwiftUI

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 40), clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // top left
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // mid right
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // bottom
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY)) // mid left
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100))
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        }
    }
}

struct CustomCurvesBootCamp: View {
    var body: some View {
        WaterShape()
            //.stroke(lineWidth: 5)
//            .frame(width: 200, height: 200)
            .fill(LinearGradient(colors: [Color.blue, Color.blue.opacity(0.5)], startPoint: .bottomLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
            
    }
}

#Preview {
    CustomCurvesBootCamp()
}
