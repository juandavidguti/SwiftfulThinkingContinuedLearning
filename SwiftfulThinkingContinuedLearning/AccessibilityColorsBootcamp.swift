//
//  AccessibilityColorsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 8/6/25.
//

import SwiftUI

struct AccessibilityColorsBootcamp: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        NavigationStack {
            VStack{
                Button("Button 1") {
                    
                }
                .foregroundStyle(colorSchemeContrast == .increased ? .green : .white)
                .buttonStyle(.borderedProminent)
                Button("Button 2") {
                    
                }
                .foregroundStyle(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                Button("Button 3") {
                    
                }
                .foregroundStyle(.white)
                
                .foregroundStyle(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.green)
                Button("Button 4") {
                    
                }
                .foregroundStyle(differentiateWithoutColor ? .white : .green)
                .buttonStyle(.borderedProminent)
                .tint(differentiateWithoutColor ? .black : .purple)
            }
            .font(.largeTitle)
//            .navigationTitle("HI")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
//            .background(reduceTransparency ? Color.black : Color.primary.opacity(0.5))
        }
        
    }
}

#Preview {
    AccessibilityColorsBootcamp()
}
