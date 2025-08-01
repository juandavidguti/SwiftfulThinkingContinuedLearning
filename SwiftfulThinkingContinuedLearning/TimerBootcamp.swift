//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 1/08/25.
//

import SwiftUI

struct TimerBootcamp: View {
    
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let timerForAnimation = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
    @State var currentData: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
        
    }
     */
    
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // Countdown to date
    /*
    
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(
        byAdding: .hour,
        value: 1,
        to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents(
            [.hour, .minute, .second],
            from: Date(),
            to: futureDate
        )
        let hour = remaining.hour ?? 00
        let minute = remaining.minute ?? 00
        let second = remaining.second ?? 00
        timeRemaining = "\(minute)minutes, \(second) seconds"
    }
    
     */
    
    // Animation Counter
    @State var count: Int = 0
    @State var countForAnimation: Int = 0
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            Spacer()
            VStack(spacing: 20) {
                TabView(selection: $count) {
                    Rectangle()
                        .foregroundStyle(.red)
                        .tag(1)
                    Rectangle()
                        .foregroundStyle(.blue)
                        .tag(2)
                    Rectangle()
                        .foregroundStyle(.green)
                        .tag(3)
                    Rectangle()
                        .foregroundStyle(.orange)
                        .tag(4)
                    Rectangle()
                        .foregroundStyle(.pink)
                        .tag(5)
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
                
                HStack(spacing: 15) {
                    Circle()
                        .offset(y: countForAnimation == 1 ? -20 : 0)
                    Circle()
                        .offset(y: countForAnimation == 2 ? -20 : 0)
                    Circle()
                        .offset(y: countForAnimation == 3 ? -20 : 0)
                }
                .frame(width: 150)
                .foregroundStyle(.white)
                Spacer()
            }
        }
        .onReceive(timer) { _ in // this listens (subscribe) to the publisher and perform an action every time the publisher send data.
            withAnimation(.default) {
                count = count == 5 ? 0 : count + 1
            }
        }
        .onReceive(timerForAnimation) { _ in // this listens (subscribe) to the publisher and perform an action every time the publisher send data.
            withAnimation(.easeInOut(duration: 0.5)) {
                countForAnimation = countForAnimation == 3 ? 0 : countForAnimation + 1
            }
        }
    }
}

#Preview {
    TimerBootcamp()
}
