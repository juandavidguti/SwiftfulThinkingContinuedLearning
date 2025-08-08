//
//  AlignmentGuideBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 8/08/25.
//

import SwiftUI

// https://swiftui-lab.com/alignment-guides/


struct AlignmentGuideBootcamp: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Hello, world!")
                .background(Color.blue)
                .alignmentGuide(.leading) { dimensions in
                    return dimensions.width // pixels
                }
            Text("This is another text!")
                .background(Color.red)
        }
        .background(Color.orange)
    }
}


struct AlignmentChildView: View {
    var body: some View {
        VStack (alignment: .leading,spacing: 20) {
            row(title: "Row 1",showIcon: true)
            row(title: "Row 2",showIcon: false)
            row(title: "Row 3",showIcon: false)
        }
        .padding(16)
        .background(Color.white)
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View{
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            Spacer()
        }
        .background(Color.red)
        .alignmentGuide(.leading) { dimensions in
            return showIcon ? 40 : 0
        }
    }
    
}

#Preview {
    AlignmentGuideBootcamp()
}
