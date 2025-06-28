//
//  RotationGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 6/27/25.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = .zero
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding()
            .rotationEffect(angle)
            .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        angle = value.rotation
                    }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            angle = .zero
                        }
                    }
            )

    }
}

#Preview {
    RotationGestureBootcamp()
}
