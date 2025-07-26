//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 22/07/25.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            starsView
                .overlay { overlayView.mask(starsView) }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    //.foregroundStyle(.yellow)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
}

#Preview {
    MaskBootcamp()
}
