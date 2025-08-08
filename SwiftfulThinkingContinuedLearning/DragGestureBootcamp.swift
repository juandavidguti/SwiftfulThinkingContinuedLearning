//
//  DragGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 6/27/25.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offSet: CGSize = .zero
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                VStack(alignment: .center) {
                    Text("\(offSet.width)")
                    Spacer()
                }
                card(proxy: proxy)
                
            }
        }
    }
    
    func getScaleAmount(proxy: GeometryProxy) -> CGFloat {
        let max = proxy.size.width / 2
        let currentAmount = abs(offSet.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount (proxy: GeometryProxy) -> Double {
        let max = proxy.size.width / 2
        let currentAmount = offSet.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    private func card(proxy: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            Text("Welcome to Soul")
                .font(.title)
                .foregroundStyle(.white)
            
            Image(systemName: "headphones")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .foregroundStyle(.white)
            
            Button(action: {
                print("Start Session")
            }) {
                Text("Start Session")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .frame(width: 250, height: 450)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
        )
        .offset(offSet)
        .scaleEffect(getScaleAmount(proxy: proxy))
        .rotationEffect(Angle(degrees: getRotationAmount(proxy: proxy)))
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        offSet = value.translation
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring) {
                        offSet = .zero
                    }
                }
        )
    }
}


#Preview {
    DragGestureBootcamp()
}
