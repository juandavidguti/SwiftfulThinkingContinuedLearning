//
//  ScrollviewReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 6/27/25.
//

import SwiftUI

struct ScrollviewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter a number here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            Text("Scroll Now Text")
                .foregroundStyle(.green)
                .fontWeight(.medium)
                .gesture(TapGesture(count: 2).onEnded({ tap in
                    withAnimation(.spring()) {
                        if let index = Int(textFieldText) {
                            scrollToIndex = index
                        }
                    }
                })
                )
            
            Button("Scroll Now") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
                
            }
            ScrollView {
                ScrollViewReader { proxy in
                    
                    ForEach(0..<50) { index in
                        Text("This is item number \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 10)))
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollviewReaderBootcamp()
}
