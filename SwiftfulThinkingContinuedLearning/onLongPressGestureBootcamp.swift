//
//  onLongPressGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 6/27/25.
//

import SwiftUI

struct onLongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: isComplete ? 300 : 50)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
              
            HStack {
                Text("Click HERE!")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50, perform: {
                        // at the main duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }, onPressingChanged: { isPressing in
                        // start of press -> to the min duration
                        if isPressing {
                            withAnimation(.easeIn(duration: 1)) {
                                isComplete.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    })
                Text("RESET")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
            
        }
//        Text(isComplete ? "Completed" : "Not completed")
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .onTapGesture {
//                isComplete.toggle()
//            }
//            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50.0) {
//                isComplete.toggle()
//            }
        
        
    }
}

#Preview {
    onLongPressGestureBootcamp()
}
