//
//  AccessibilityTextBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by JUAN OLARTE on 8/6/25.
//

import SwiftUI


// Dynamic Text

struct AccessibilityTextBootcamp: View {
    
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading,spacing: 8) {
                        HStack{
                            Image(systemName: "heart.fill")
                            Text("Welcome to my App")
                                .truncationMode(.tail)
                        }
                        .font(.title)
                        Text("This is some longer texts that expands to multiple lines!")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .truncationMode(.head)
                            .lineLimit(3)
                            .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                    }
//                    .frame(height: 100) Remove any fix sizes, use max width max heights, paddings, spacings.
                    .background(Color.red)
                    
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hello world!")
        }
    }
}

extension DynamicTypeSize {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .xSmall, .small, .medium:
            return 1.0
        case .large, .xLarge:
            return 0.8
        default:
            return 0.9
        }
    }
}

/*
 /// An extra small size.
 case xSmall

 /// A small size.
 case small

 /// A medium size.
 case medium

 /// A large size.
 case large

 /// An extra large size.
 case xLarge

 /// An extra extra large size.
 case xxLarge

 /// An extra extra extra large size.
 case xxxLarge

 /// The first accessibility size.
 case accessibility1

 /// The second accessibility size.
 case accessibility2

 /// The third accessibility size.
 case accessibility3

 /// The fourth accessibility size.
 case accessibility4

 /// The fifth accessibility size.
 case accessibility5
 */

#Preview {
    AccessibilityTextBootcamp()
}
