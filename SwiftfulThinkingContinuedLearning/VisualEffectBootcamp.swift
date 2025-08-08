//
//  VisualEffectBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 8/08/25.
//

import SwiftUI

// If we're using Geometry reader please replace with Visual Effect.

struct VisualEffectBootcamp: View {
    
//    @State private var showSpacer: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 40) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .frame(width: 300,height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .visualEffect { EmptyVisualEffect, geometry in
                            EmptyVisualEffect
                                .offset(x: geometry.frame(in: .global).minY * 0.5)
                        }
                }
            }
        }
        
//        VStack {
//            Text("ahsahdfahsdghasdhgashdl;g")
//                .padding()
//                .frame(width: 200)
//                .background(Color.red)
//                .visualEffect { content, geometry in
//                    content
//                        .grayscale(geometry.frame(in: .global).minY < 300 ? 1 : 0)
////                        .grayscale(geometry.size.width >= 200 ? 1 : 0)
//                }
//            Spacer()
//        }
//        .animation(.easeIn, value: showSpacer)
//        .onTapGesture {
//            showSpacer.toggle()
//        }
    }
}

#Preview {
    VisualEffectBootcamp()
}
