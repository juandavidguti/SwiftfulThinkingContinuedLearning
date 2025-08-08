//
//  ScrollViewPagingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 8/08/25.
//

import SwiftUI

struct ScrollViewPagingBootcamp: View {
    
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        
        Button("Scroll to") {
            scrollPosition = (0..<20).randomElement()
        }
        
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(0..<20) { index in
                    Rectangle()
                        
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            Text("\(index)").foregroundStyle(.white)
                        }
                        
                        .frame(maxWidth: .infinity)
                        .padding()
                        .id(index)
                        .scrollTransition(transition: { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .offset(y:phase.isIdentity ? 0 : -100)
                        })
//                        .containerRelativeFrame(.horizontal,alignment: .center) // permite enfocarse solo en cada tarjeta o contenido.
                }
            }
            .padding(.vertical,100)
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned) // alinea con el objeto y su frame ultimo en la parte superior.
//        .scrollTargetBehavior(.paging) // move the full page to the next part of the scroll (pages like reels)
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPagingBootcamp()
}
