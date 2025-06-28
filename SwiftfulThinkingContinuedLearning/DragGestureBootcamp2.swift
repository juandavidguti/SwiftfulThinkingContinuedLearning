//
//  DragGestureBootcamp2.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 6/27/25.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State var startingOffsetY: CGFloat = 0.0
    @State var currentDragOffSetY: CGFloat = 0
    @State var endingOffSetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.green.ignoresSafeArea()
                
                MySignUpView()
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffSetY)
                    .offset(y: endingOffSetY)
                    .onAppear {
                        startingOffsetY = proxy.size.height * 0.95
                    }
                    .gesture(DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                currentDragOffSetY = value.translation.height
                            }
                            
                        } .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDragOffSetY < -150 {
                                    endingOffSetY = -startingOffsetY
                                    
                                    
                                } else if endingOffSetY != 0 && currentDragOffSetY > 150 {
                                    endingOffSetY = 0
                                    
                                }
                                currentDragOffSetY = 0
                            }
                            
                        }
                    )
//                Text("\(currentDragOffSetY)")
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    DragGestureBootcamp2()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up!")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favorite SwiftUI course and I recommend to all of my friends to subscribe to Swiftful Thinking")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Create an account!")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.clipShape(RoundedRectangle(cornerRadius: 10)))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 30)))
    }
}
