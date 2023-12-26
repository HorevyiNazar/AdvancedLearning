//
//  TimelineViewBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 26/12/2023.
//

import SwiftUI

struct TimelineViewBootCamp: View {
    
    @State private var startTime: Date = .now
    @State private var pauseAnimation: Bool = false
    
    var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 1, paused: pauseAnimation)) { context in
                
                Text("\(context.date)")
                
//                let seconds = Calendar.current.component(.second, from: context.date)
                
                let seconds = context.date.timeIntervalSince(startTime)
                
                if context.cadence == .live {
                    Text("Cadence is live")
                } else if context.cadence == .minutes {
                    Text("Cadence is minutes")
                } else if context.cadence == .seconds {
                    Text("Cadence is seconds")
                }
                
                Rectangle()
                    .frame(
                        width: seconds < 10 ? 50 : seconds < 30 ? 200 : 400 ,
                        height: 100
                    )
                    .animation(.bouncy, value: seconds)
                
            }
            
            Button(pauseAnimation ? "Play" : "Pause") {
                pauseAnimation.toggle()
            }
        }
    }
}

#Preview {
    TimelineViewBootCamp()
}
